# OCI Terraform for PeopleSoft Cloud Manager

1. Install Terraform
1. Clone the repo
1. Run `terraform init`
1. Save `sandbox.tfvars.example` to `sandbox.tfvars`
1. Edit `sandbox.tfvars`
1. Run `terraform apply --var-file=sandbox.tfvars`

## Editing `.tfvars` file
1. setup the oci cli tool
    1. todo
1. tenancy_ocid 
    1. From compute homepage, click User icon top right
    1. Tenacy
    1. Tenancy Info...ocid
1. user_ocid is your login
    1. top left menu, Identity > Users
    1. Click on User
    1. Copy OCID
1. Add puclic Key
    1. same as above (user_ocid)
    1. generate a key (oci command line tool is best)
    1. otherwise putty?
    1. Click add public key
1. fingerprint
    1. pulled in from PUblic Key entry, after added
1. private_key_path
    1. whatever you setup during ocicli setup
1. region is your region
    1. same as ocicli setup
1. to review data from ocicli?
    1. cd ~/.oci
    1. cat config

## Helpful Resources

* [Terraform OCI Provider Documentation](https://www.terraform.io/docs/providers/oci/index.html)
* [Example OCI Terraform Project](https://github.com/gregoryguillou/oci-workshop)
* [PeopleTools blog post on setting up OCI for Cloud Manager](https://blogs.oracle.com/peopletools/how-to-set-up-oci-tenancy-for-peoplesoft-cloud-manager-–-part-i)
* [Oracle documentation on setting up Cloud Manager](http://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/compute-iaas/install_peoplesoft_cloud_manager_oci/cloud-manager-install-oracle-cloud-infrastructure.html#section7)