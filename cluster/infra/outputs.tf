output "ssh_ip" {
  value = cloudca_public_ip.nat_ip.ip_address
}
output "control_plane_ep" {
  value = cloudca_public_ip.master_ep.ip_address
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.ini.tpl",
    {
      master_names    = cloudca_instance.masters.*.name
      master_ssh_port = cloudca_port_forwarding_rule.masters.*.public_port_start
      worker_names    = cloudca_instance.workers.*.name
      worker_ssh_port = cloudca_port_forwarding_rule.workers.*.public_port_start
      ssh_ip          = cloudca_public_ip.nat_ip.ip_address
  })
  filename = "../inventory.ini"
}
