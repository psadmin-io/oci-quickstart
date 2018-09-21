data "oci_objectstorage_namespace" "ns" {}

resource "oci_objectstorage_bucket" "sandbox_bucket" {
  compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
  name = "${var.oci_name}"
  namespace = "${data.oci_objectstorage_namespace.ns.namespace}"
}

output namespace {
  value = "${data.oci_objectstorage_namespace.ns.namespace}"
}