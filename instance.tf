resource "oci_core_instance" "cm_instance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.primary_availability_domains.availability_domains[0],"name")}"
  compartment_id      = "${oci_identity_compartment.sandbox_compartment.id}"
  display_name        = "CloudManager"
  shape               = "${var.shape}"

  create_vnic_details {
    subnet_id        = "${oci_core_subnet.sandbox_subnet.0.id}"
    display_name     = "cmprimaryvnic"
    assign_public_ip = true
    hostname_label   = "CloudManager"
  }

  source_details {
    source_type = "image"
    source_id   = "${oci_core_app_catalog_subscription.cm_app_catalog_subscription.listing_resource_id}"
  }

  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
  }

}

output cloud_manager_public_ip {
  value = ["${oci_core_instance.cm_instance.*.public_ip}"]
}