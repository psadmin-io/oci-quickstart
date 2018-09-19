# Configure the Oracle Cloud Infrastructure provider with an API Key
provider "oci" {
  tenancy_ocid = "${var.tenancy_ocid}"
  user_ocid = "${var.user_ocid}"
  fingerprint = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region = "${var.region}"
}

# Data Sources
data "oci_identity_availability_domains" "primary_availability_domains" {
  compartment_id = "${var.tenancy_ocid}"
}

# OCI Compartment
resource "oci_identity_compartment" "sandbox_compartment" {
	compartment_id = "${var.tenancy_ocid}"
	description = "${var.compartment_description}"
	name = "${var.oci_name}"
}

# User Security
resource "oci_identity_group" "sandbox_group" {
  compartment_id = "${var.tenancy_ocid}"
  description = "${var.group_description}"
  name = "${var.oci_name}"
}

resource "oci_identity_policy" "sandbox_policy" {
  compartment_id = "${var.tenancy_ocid}"
  description = "${var.policy_description}"
  name = "${var.oci_name}"
  statements = "${var.policy_statements}"

  depends_on = ["oci_identity_group.sandbox_group"]
}

resource "oci_identity_user" "sandbox_user" {
  compartment_id = "${var.tenancy_ocid}"
  description = "${var.user_description}"
  name = "${var.oci_name}"
}

resource "oci_identity_user_group_membership" "sandbox_user_group_membership" {
  group_id = "${oci_identity_group.sandbox_group.id}"
  user_id = "${oci_identity_user.sandbox_user.id}"
}

resource "oci_identity_api_key" "sandbox_api_key" {
  key_value = "${var.api_key_key_value}"
  user_id = "${oci_identity_user.sandbox_user.id}"
}

# Networking
resource "oci_core_vcn" "sandbox_vcn" {
  cidr_block = "${var.vcn_cidr_block}"
  display_name = "Sandbox-Network"
  compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
}

resource "oci_core_internet_gateway" "sandbox_internet_gateway" {
  compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
  vcn_id = "${oci_core_vcn.sandbox_vcn.id}"
}

resource "oci_core_route_table" "sandbox_route_table" {
  compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
  vcn_id         = "${oci_core_vcn.sandbox_vcn.id}"
  
  route_rules {
    destination        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.sandbox_internet_gateway.id}"
  }
}

// resource "oci_core_subnet" "public-subnet" {
//   count               = 3
//   availability_domain = "${lookup(data.oci_identity_availability_domains.primary_availability_domains.availability_domains[count.index],"name")}"
//   cidr_block          = "10.0.${count.index}.0/24"
//   display_name        = "${oci_core_virtual_network.main.display_name}-subnet${count.index}pub"
//   dns_label           = "subnet${count.index}pub"
//   security_list_ids   = ["${oci_core_security_list.public-sl.id}"]
//   compartment_id      = "${var.compartment}"
//   vcn_id              = "${oci_core_virtual_network.main.id}"
//   route_table_id      = "${oci_core_route_table.public-rt.id}"
//   dhcp_options_id     = "${oci_core_dhcp_options.DhcpOptions.id}"
// }