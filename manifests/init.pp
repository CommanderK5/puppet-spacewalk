# Class: spacewalk
# ===========================
#
#  The spacewalk module installs and configures Spacewalk server.
#
#
# Example
#============================
#
# Enable with defaults:
#  class {'spacewalk':}
#
# Spacewalk setup with external postgrsql:
#  class { 'spacewalk': 
#    db_backend          => postgresql,
#    postgresql_embedded => false,
#    db_name             => spacedb,
#    db_user             => user, 
#    db_password         => mypassword,
#    db_host             => exampledb.test.com
#  }
#
#
# Authors
# -------
#
# Lukasz Rohde <kujon447@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2015 Lukasz Rohde.
#
class spacewalk (

  ### service
  $service_ensure              = running,

  ### answer file
  $db_backend                  = $spacewalk::params::db_backend,
  $postgresql_embedded         = $spacewalk::params::postgresql_embedded,
  $db_name                     = $spacewalk::params::db_name,
  $db_user                     = $spacewalk::params::db_user,
  $db_password                 = $spacewalk::params::db_password,
  $db_host                     = $spacewalk::params::db_host,
  $db_port                     = $spacewalk::params::db_port,
  $admin_email                 = $spacewalk::params::admin_email,
  $configure_apache_ssl        = $spacewalk::params::configure_apache_ssl,
  $ca_cert_password            = $spacewalk::params::ca_cert_password,
  $ca_organization             = $spacewalk::params::ca_organization,
  $ca_organization_unit        = $spacewalk::params::ca_organization_unit,
  $ca_email_address            = $spacewalk::params::ca_email_address,
  $ca_city                     = $spacewalk::params::ca_city,
  $ca_state                    = $spacewalk::params::ca_state,
  $ca_country_code             = $spacewalk::params::ca_country_code,
  $enable_tftp                 = $spacewalk::params::enable_tftp,

  ### setup options
  $disconnected_opt            = true,
  $re_register_opt             = false,
  $clear_db_opt                = false,

  ### skip options
  $skip_selinux_test_opt       = false,
  $skip_db_diskspace_check_opt = true,
  $skip_db_install_opt         = false,
  $skip_fqdn_test_opt          = false,
  $skip_db_population_opt      = false,



) inherits spacewalk::params {

  include spacewalk::packages
  include spacewalk::setup
  include spacewalk::service

  Class['spacewalk::packages'] ->
  Class['spacewalk::setup']    ->
  Class['spacewalk::service']  ->
  Class['spacewalk']
}
