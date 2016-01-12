# Class spacewalk::package
# ===========================
#
# Install required packages
# This Class shoud not be call directly, call class spacewalk for installation.

class spacewalk::packages (

  $db_backend          = $spacewalk::db_backend,
  $postgresql_embedded = $spacewalk::postgresql_embedded,

){

  case $db_backend {
    'postgresql': {
      if $postgresql_embedded == true {
        package {'spacewalk-setup-postgresql':
          ensure => installed,
          before => Package['spacewalk-postgresql'],
        }
      }
      package {'spacewalk-postgresql':
        ensure  => installed,
      }
    }
    'oracle': {
      package {'spacewalk-oracle':
        ensure  => installed,
      }
    }
    default: { fail('Unsupported backend')}
  }
}
