# Networking
resource "oci_core_vcn" "sandbox_vcn" {
  cidr_block = "${var.vcn_cidr_block}"
  display_name = "Sandbox Network"
  compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
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
    display_name = "${var.domain} DHCP Options"
    options {
        type = "DomainNameServer"
        server_type = "VcnLocalPlusInternet"
    }

    options {
        type = "SearchDomain"
        search_domain_names = [ "${var.domain}" ]
    }

    vcn_id = "${oci_core_vcn.sandbox_vcn.id}"
}

resource "oci_core_subnet" "sandbox-subnet" {
  count               = 3
  // availability_domain = "${lookup(data.oci_identity_availability_domains.primary_availability_domains.availability_domains[count.index],"name")}"
  availability_domain = "${var.availability_domain}"
  cidr_block          = "10.0.${count.index}.0/24"
  display_name        = "${oci_core_vcn.sandbox_vcn.display_name} Subnet ${count.index}"
  // dns_label           = "subnet${count.index}sandbox"
  security_list_ids   = [
    "${oci_core_security_list.sandbox_nfs_security_list.id}",
    "${oci_core_security_list.sandbox_midtier_security_list.id}",
    "${oci_core_security_list.sandbox_db_security_list.id}" ]
  compartment_id      = "${oci_identity_compartment.sandbox_compartment.id}"
  vcn_id              = "${oci_core_vcn.sandbox_vcn.id}"
  route_table_id      = "${oci_core_route_table.sandbox_route_table.id}"
  dhcp_options_id     = "${oci_core_dhcp_options.sandbox_dhcp_options.id}"
}