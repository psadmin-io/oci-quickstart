resource "oci_core_vcn" "sandbox_vcn" {
  cidr_block = "${var.vcn_cidr_block}"
  display_name = "Sandbox Network"
  compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
  dns_label = "${var.vcn_label}"
}

resource "oci_core_internet_gateway" "sandbox_internet_gateway" {
  compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
  display_name = "Sandbox Internet Gateway"
  vcn_id = "${oci_core_vcn.sandbox_vcn.id}"
}

resource "oci_core_route_table" "sandbox_route_table" {
  compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
  vcn_id         = "${oci_core_vcn.sandbox_vcn.id}"
  display_name = "Sandbox Route Table"
  
  route_rules {
    destination        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.sandbox_internet_gateway.id}"
  }
}

resource "oci_core_dhcp_options" "sandbox_dhcp_options" {
    #Required
    compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
    display_name = "${var.oci_name} DHCP Options"
    options {
        type = "DomainNameServer"
        server_type = "VcnLocalPlusInternet"
    }

    options {
        type = "SearchDomain"
        search_domain_names = [ "${var.vcn_label}.oraclevcn.com" ]
    }

    vcn_id = "${oci_core_vcn.sandbox_vcn.id}"
}

resource "oci_core_subnet" "sandbox_subnet" {
  count               = 3
  cidr_block          = "10.0.${count.index}.0/24"
  display_name        = "${oci_core_vcn.sandbox_vcn.display_name} Subnet - ${element(var.dns_label, count.index)}"
  dns_label           = "${element(var.dns_label, count.index)}"
  security_list_ids   = [
    "${oci_core_security_list.sandbox_security_list.id}",
    "${oci_core_security_list.sandbox_nfs_security_list.id}",
    "${oci_core_security_list.sandbox_midtier_security_list.id}",
    "${oci_core_security_list.sandbox_db_security_list.id}" ]
  compartment_id      = "${oci_identity_compartment.sandbox_compartment.id}"
  vcn_id              = "${oci_core_vcn.sandbox_vcn.id}"
  route_table_id      = "${oci_core_route_table.sandbox_route_table.id}"
  dhcp_options_id     = "${oci_core_dhcp_options.sandbox_dhcp_options.id}"

  depends_on = ["oci_core_vcn.sandbox_vcn"]
}

output "sandbox_subnets" {
  value = "${oci_core_subnet.sandbox_subnet.*.id}"
}