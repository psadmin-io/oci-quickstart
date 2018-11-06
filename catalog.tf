data "oci_core_app_catalog_listings" "cm_app_catalog_listings" {
  filter {
    name   = "display_name"
    values = ["PeopleSoft Cloud Manager Image - OCI"]
  }
}

output "catalog_listing" {
   value = "${data.oci_core_app_catalog_listings.cm_app_catalog_listings.app_catalog_listings}"
}