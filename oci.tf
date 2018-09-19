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