
resource "oci_core_security_list" "sandbox_security_list" {
  compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
  display_name = "Sandbox Default Security List"

  egress_security_rules = [
    {
      protocol    = "all"
      destination = "0.0.0.0/0"
    }
  ]
  ingress_security_rules = [
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options = {
        min = "22"
        max = "22"
      }
    },{
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options = {
        min = "8443"
        max = "8643"
      }
    },{
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options = {
        min = "8000"
        max = "8200"
      }
    },{
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options = {
        min = "3389"
        max = "3389"
      }
    },{
      protocol = "6"
      source   = "10.0.1.0/24"
    }
  ]
  vcn_id = "${oci_core_vcn.sandbox_vcn.id}"
}

#
# Primary Subnet - NFS
resource "oci_core_security_list" "sandbox_nfs_security_list" {
  compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
  display_name = "Sandbox NFS Security List"
  
  ingress_security_rules = [
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options = {
        min = "22"
        max = "22"
      }
    },{
      protocol = "6"
      source   = "10.0.0.0/24"

      tcp_options = {
        min = "2049"
        max = "2049"
      }
    },{
      protocol = "6"
      source   = "10.0.0.0/24"

      tcp_options = {
        min = "111"
        max = "111"
      }
    },{
      protocol = "6"
      source   = "10.0.0.0/24"

      tcp_options = {
        min = "892"
        max = "892"
      }
    },{
      protocol = "6"
      source   = "10.0.0.0/24"

      tcp_options = {
        min = "32803"
        max = "32803"
      }
    },{
      protocol = "6"
      source   = "10.0.1.0/24"

      tcp_options = {
        min = "2049"
        max = "2049"
      }
    },{
      protocol = "6"
      source   = "10.0.1.0/24"

      tcp_options = {
        min = "111"
        max = "111"
      }
    },{
      protocol = "6"
      source   = "10.0.1.0/24"

      tcp_options = {
        min = "892"
        max = "892"
      }
    },{
      protocol = "6"
      source   = "10.0.1.0/24"

      tcp_options = {
        min = "32803"
        max = "32803"
      }
    },{
      protocol = "6"
      source   = "10.0.2.0/24"

      tcp_options = {
        min = "2049"
        max = "2049"
      }
    },{
      protocol = "6"
      source   = "10.0.2.0/24"

      tcp_options = {
        min = "111"
        max = "111"
      }
    },{
      protocol = "6"
      source   = "10.0.2.0/24"

      tcp_options = {
        min = "892"
        max = "892"
      }
    },{
      protocol = "6"
      source   = "10.0.2.0/24"

      tcp_options = {
        min = "32803"
        max = "32803"
      }
    }
  ]
  vcn_id = "${oci_core_vcn.sandbox_vcn.id}"
}

#
# Second Subnet - Midtier
resource "oci_core_security_list" "sandbox_midtier_security_list" {
  compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
  display_name = "Sandbox Midtier Security List"
  
  ingress_security_rules = [
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options = {
        min = "22"
        max = "22"
      }
    },{
      protocol = "6"
      source   = "10.0.0.0/24"

      tcp_options = {
        min = "5985"
        max = "5986"
      }
    },{
      protocol = "6"
      source   = "10.0.1.0/24"

      tcp_options = {
        min = "${var.http_port}"
        max = "${var.http_port}"
      }
    },{
      protocol = "6"
      source   = "10.0.1.0/24"

      tcp_options = {
        min = "8443"
        max = "8443"
      }
    },{
      protocol = "6"
      source   = "10.0.1.0/24"

      tcp_options = {
        min = "9033"
        max = "9053"
      }
    },{
      protocol = "6"
      source   = "10.0.1.0/24"

      tcp_options = {
        min = "3389"
        max = "3389"
      }
    },{
      protocol = "6"
      source   = "10.0.1.0/24"

      tcp_options = {
        min = "9200"
        max = "9200"
      }
    },{
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options = {
        min = "3389"
        max = "3389"
      }
    }
  ]
  vcn_id = "${oci_core_vcn.sandbox_vcn.id}"
}

# 
# Third Subnet - Database
resource "oci_core_security_list" "sandbox_db_security_list" {
  compartment_id = "${oci_identity_compartment.sandbox_compartment.id}"
  display_name = "Sandbox DB Security List"
  
  ingress_security_rules = [
    {
      protocol = "6"
      source   = "10.0.0.0/24"

      tcp_options = {
        min = "22"
        max = "22"
      }
    },{
      protocol = "6"
      source   = "10.0.0.0/24"

      tcp_options = {
        min = "1521"
        max = "1522"
      }
    }
  ]
  vcn_id = "${oci_core_vcn.sandbox_vcn.id}"
}