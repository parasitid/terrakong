provider "openstack" {
    user_name  = "${var.username}"
    tenant_name = "${var.tenant_name}"
    password  = "${var.password}"
    auth_url  = "${var.auth_url}"
}

resource "openstack_compute_keypair_v2" "terrakong_keypair" {
  name = "terrakong-keypair"
  region = "${var.region}"
  public_key = "${var.public_key}"
}

resource "openstack_compute_floatingip_v2" "terrakong_ips" {
  region = "${var.region}"
  pool = "${lookup(var.pub_net_id, var.region)}"
  count = "${var.nb_of_nodes}"
}

resource "openstack_compute_instance_v2" "nodes" {
  name = "node-${count.index}"
  region = "${var.region}"
  image_id = "${lookup(var.images, var.region)}"
  flavor_id = "${lookup(var.flavors, var.region)}"
  floating_ip = "${element(openstack_compute_floatingip_v2.terrakong_ips.*.address,count.index)}"
  metadata {
    this = "that"
  }
  key_pair = "terrakong-keypair"
  count = "${var.nb_of_nodes}"
}

output "nodes_floating_ips" {
  value = "${join(\",\", openstack_compute_instance_v2.nodes.*.floating_ip)}"
}
