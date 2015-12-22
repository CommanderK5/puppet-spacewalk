# Class: spacewalk::repo::client
#
# Setup spacewalk yum repositories 
#
# Examples:
#
# Enable with defaults:
#  include spacewalk::repo::client
#
# Enable spacewalk client 2.4 repo:
#  class {'spacewalk_repo':
#    client_repo_enabled  => '1',
#    client_repo_gpgcheck => '1',
#    client_repo_release  => '2.4',
#    client_repo_gpgkey   => 'http://yum.spacewalkproject.org/RPM-GPG-KEY-spacewalk-2015',
#  }
#

class spacewalk::repo::client (
  $client_repo_enabled  = '1',
  $client_repo_gpgcheck = '1',
  $client_repo_release  = 'latest',
  $client_repo_gpgkey   = 'http://yum.spacewalkproject.org/RPM-GPG-KEY-spacewalk-2015',
){

  case $::osfamily {
    'RedHat': {

      yumrepo {'spacewalk-client':
        enabled  => $client_repo_enabled,
        descr    => "Spacewalk Client ${client_repo_release} Repository",
        gpgcheck => $client_repo_gpgcheck,
        gpgkey   => $client_repo_gpgkey,
        baseurl  => "http://yum.spacewalkproject.org/${client_repo_release}-client/RHEL/${::operatingsystemmajrelease}/\$basearch/",
      }
    }
    
    default: {
      fail("OS ${::operatingsystem} not supported")
    }
  }
}
