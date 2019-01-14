data "oci_core_app_catalog_listings" "cm_app_catalog_listings" {
  filter {
    name   = "display_name"
    values = ["PeopleSoft Cloud Manager Image - OCI"]
  }
}

data "oci_core_app_catalog_listing_resource_versions" "cm_app_catalog_listing_resource_versions" {
  #Required
  listing_id = "${lookup(data.oci_core_app_catalog_listings.cm_app_catalog_listings.app_catalog_listings[0],"listing_id")}"
}

data "oci_core_app_catalog_listing_resource_version" "cm_app_catalog_listing_resource_version" {
  #Required
  listing_id               = "${lookup(data.oci_core_app_catalog_listings.cm_app_catalog_listings.app_catalog_listings[0],"listing_id")}"
  resource_version = "${lookup(data.oci_core_app_catalog_listing_resource_versions.cm_app_catalog_listing_resource_versions.app_catalog_listing_resource_versions[0],"listing_resource_version")}"
}

resource "oci_core_app_catalog_listing_resource_version_agreement" "cm_app_catalog_listing_resource_version_agreement" {
  #Required
  listing_id               = "${data.oci_core_app_catalog_listing_resource_version.cm_app_catalog_listing_resource_version.listing_id}"
  listing_resource_version = "${data.oci_core_app_catalog_listing_resource_version.cm_app_catalog_listing_resource_version.listing_resource_version}"
}

resource "oci_core_app_catalog_subscription" "cm_app_catalog_subscription" {
  compartment_id           = "${oci_identity_compartment.sandbox_compartment.id}"
  eula_link                = "${oci_core_app_catalog_listing_resource_version_agreement.cm_app_catalog_listing_resource_version_agreement.eula_link}"
  listing_id               = "${oci_core_app_catalog_listing_resource_version_agreement.cm_app_catalog_listing_resource_version_agreement.listing_id}"
  listing_resource_version = "${oci_core_app_catalog_listing_resource_version_agreement.cm_app_catalog_listing_resource_version_agreement.listing_resource_version}"
  oracle_terms_of_use_link = "${oci_core_app_catalog_listing_resource_version_agreement.cm_app_catalog_listing_resource_version_agreement.oracle_terms_of_use_link}"
  signature                = "${oci_core_app_catalog_listing_resource_version_agreement.cm_app_catalog_listing_resource_version_agreement.signature}"
  time_retrieved           = "${oci_core_app_catalog_listing_resource_version_agreement.cm_app_catalog_listing_resource_version_agreement.time_retrieved}"

  timeouts {
    create = "20m"
  }
}

// data "oci_core_app_catalog_subscriptions" "cm_app_catalog_subscriptions" {
//   #Required
//   compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"

//   #Optional
//   listing_id = "${oci_core_app_catalog_subscription.cm_app_catalog_subscription.listing_id}"

//   filter {
//     name   = "listing_resource_version"
//     values = ["${oci_core_app_catalog_subscription.cm_app_catalog_subscription.listing_resource_version}"]
//   }
// }

// output "subscriptions" {
//   value = ["${data.oci_core_app_catalog_subscriptions.cm_app_catalog_subscriptions.app_catalog_subscriptions}"]
// }

// output agreement_eula_link {
//   value = ["${oci_core_app_catalog_listing_resource_version_agreement.cm_app_catalog_listing_resource_version_agreement.eula_link}"]
// }

// output catalog_listing {
//    value = "${data.oci_core_app_catalog_listings.cm_app_catalog_listings.app_catalog_listings}"
// }