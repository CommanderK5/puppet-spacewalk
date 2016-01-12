# Class: spacewalk::repo::server
# ===========================
#
# Setup spacewalk yum repositories 
#
# Examples:
# ---------
#
# Enable with defaults:
#  include spacewalk::repo::server
#
# Enable latest spacewalk repo:
#  class {'spacewalk::repo::server':
#    spacewalk_repo_enabled  => '1',
#    spacewalk_repo_gpgcheck => '1',
#    spacewalk_repo_release  => 'latest',
#    spacewalk_repo_gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-spacewalk-2015',
#  }
#
class spacewalk::repo::server (
  $spacewalk_repo_enabled   = '1',
  $spacewalk_repo_gpgcheck  = '1',
  $spacewalk_repo_release   = 'latest',
  $spacewalk_repo_gpgkey    = 'http://yum.spacewalkproject.org/RPM-GPG-KEY-spacewalk-2015',

  $jpackage_repo_enabled    = '1',
  $jpackage_repo_gpgcheck   = '1',
  $jpackage_repo_mirrorlist = 'http://www.jpackage.org/mirrorlist.php?dist=generic&type=free&release=5.0',
  $jpackage_repo_baseurl    = 'absent',
  $jpackage_repo_gpgkey     = 'http://www.jpackage.org/jpackage.asc',
){

  case $::osfamily {
    'RedHat': {

      yumrepo {'spacewalk':
        enabled  => $spacewalk_repo_enabled,
        descr    => "Spacewalk ${spacewalk_repo_release} Repository",
        gpgcheck => $spacewalk_repo_gpgcheck,
        gpgkey   => $spacewalk_repo_gpgkey,
        baseurl  => "http://yum.spacewalkproject.org/${spacewalk_repo_release}/RHEL/${::operatingsystemmajrelease}/\$basearch/",
    }
    
      yumrepo {'jpackage-generic':
        enabled    => $jpackage_repo_enabled,
        descr      => 'Jpackage Generic Repository',
        gpgcheck   => $jpackage_repo_gpgcheck,
        gpgkey     => $jpackage_repo_gpgkey,
        mirrorlist => $jpackage_repo_mirrorlist,
        baseurl    => $jpackage_repo_baseurl,
      }
    }
    default: {
      fail("OS ${::operatingsystem} not supported")
    }
  }
}


