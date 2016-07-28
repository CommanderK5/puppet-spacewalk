# Class spacewalk_repo::params
# ===========================
#
# Default values for spacewalk module 
#
class spacewalk::params {

  case $::operatingsystem {
    'RedHat', 'CentOS': {

      $db_backend                  = 'postgresql'
      $postgresql_embedded         = true
      $db_name                     = 'spaceschema'
      $db_user                     = 'spaceuser'
      $db_password                 = 'spacepass'
      $db_host                     = 'localhost' # must be localhost for embedded postgresql db setup
      $db_port                     = '5432'
      $admin_email                 = 'root@localhost'
      $configure_apache_ssl        = true
      $ca_cert_password            = 'certpass'
      $ca_organization             = 'operations'
      $ca_organization_unit        = $::fqdn
      $ca_email_address            = 'root@localhost'
      $ca_city                     = 'Belfast'
      $ca_state                    = 'NI'
      $ca_country_code             = 'GB'
      $enable_tftp                 = false # TFTP Support

    }
    default: {
      fail("Operatingsystem ${::operatingsystem} not supported")
    }
  }
}
