// resource "oci_core_instance" "pic_instance" {
//   availability_domain = "${lookup(data.oci_identity_availability_domains.primary_availability_domains[var.availability_domain - 1],"name")}"
//   compartment_id      = "${var.compartment_ocid}"
//   display_name        = "pic_instance"
//   shape               = "${var.instance_shape}"

//   create_vnic_details {
//     subnet_id        = "${oci_core_subnet.pic_subnet.id}"
//     display_name     = "picprimaryvnic"
//     assign_public_ip = true
//     hostname_label   = "PICInstance"
//   }

//   source_details {
//     source_type = "image"
//     source_id   = "${lookup(data.data.oci_core_app_catalog_listings.cm_app_catalog_listings.app_catalog_listings[0], "listing_resource_id")}"
//   }

//   metadata {
//     ssh_authorized_keys = "${var.ssh_public_key}"
//   }

//   timeouts {
//     create = "60m"
//   }
// }