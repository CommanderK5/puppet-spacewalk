# Class spacewalk::setup
# ===========================
#
# Initial spacewalk server setup

class spacewalk::setup (

  $db_backend                  = $spacewalk::db_backend,
  $postgresql_embedded         = $spacewalk::postgresql_embedded,
  $db_name                     = $spacewalk::db_name,
  $db_user                     = $spacewalk::db_user,
  $db_password                 = $spacewalk::db_password,
  $db_host                     = $spacewalk::db_host,
  $db_port                     = $spacewalk::db_port,
  $admin_email                 = $spacewalk::admin_email,
  $configure_apache_ssl        = $spacewalk::configure_apache_ssl,
  $ca_cert_password            = $spacewalk::ca_cert_password,
  $ca_organization             = $spacewalk::ca_organization,
  $ca_organization_unit        = $spacewalk::ca_organization_unit,
  $ca_email_address            = $spacewalk::ca_email_address,
  $ca_city                     = $spacewalk::ca_city,
  $ca_state                    = $spacewalk::ca_state,
  $ca_country_code             = $spacewalk::ca_country_code,
  $enable_tftp                 = $spacewalk::enable_tftp,
  
  $disconnected_opt            = $spacewalk::disconnected_opt,
  $re_register_opt             = $spacewalk::re_register_opt,
  $clear_db_opt                = $spacewalk::clear_db_opt,
  
  $skip_selinux_test_opt       = $spacewalk::skip_selinux_test_opt,
  $skip_db_diskspace_check_opt = $spacewalk::skip_db_diskspace_check_opt,
  $skip_db_install_opt         = $spacewalk::skip_db_install_opt,
  $skip_db_population_opt      = $spacewalk::skip_db_population_opt,
  $skip_fqdn_test_opt          = $spacewalk::skip_fqdn_test_opt,
){

  case $db_backend {
    'postgresql': {
      if $postgresql_embedded == false {
          $external = '--external-postgresql'
      }
      else { $external = '' }
    }
    'oracle': {
      $external = '--external-oracle'
    }
    default:  {
      $external = ''
    }
  }

  $re_register = $re_register_opt ? {
    true    => '--re-register',
    false   => '',
    default => '',
  }

  $clear_db = $clear_db_opt ? {
    true    => '--clear-db',
    false   => '',
    default => '',
  }

  $skip_selinux_test = $skip_selinux_test_opt ? {
    true    => '--skip-selinux-test',
    false   => '',
    default => '',
  }

  $skip_db_diskspace_check = $skip_db_diskspace_check_opt ? {
    true    => '--skip-db-diskspace-check',
    false   => '',
    default => '',
  }

  $skip_db_install = $skip_db_install_opt ? {
    true    => '--skip-db-install',
    false   => '',
    default => '',
  }

  $skip_db_population = $skip_db_population_opt ? {
    true    => '--skip-db-population',
    false   => '',
    default => '',
  }
  
  $skip_fqdn_test = $skip_fqdn_test_opt ? {
    true    => '--skip-fqdn-test',
    false   => '',
    default => '',
  }

  $setup_opts = "${external} ${re_register} ${clear_db}"
  $skip_opts  = "${skip_db_diskspace_check} ${skip_selinux_test} ${skip_db_install} ${skip_db_population} ${skip_fqdn_test}"
  $command    = "spacewalk-setup --answer-file=/etc/sysconfig/spacewalk.answer --non-interactive ${setup_opts} ${skip_opts}"
  
  file {'/etc/sysconfig/spacewalk.answer':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    content => template('spacewalk/spacewalk.answer.erb'),
    notify  => Exec['spacewalk-setup'],
  }

  file {'/usr/bin/spacewalk.sh':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    content => $command,
    notify  => Exec['spacewalk-setup'],
  }

  exec {'spacewalk-setup':
    cwd         => '/root',
    command     => '/usr/bin/spacewalk.sh',
    refreshonly => true,
    logoutput   => on_failure,
    require     => File['/etc/sysconfig/spacewalk.answer','/usr/bin/spacewalk.sh'],
  }
}
