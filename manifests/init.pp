# Class: spacewalk
# ===========================
#
# Full description of class spacewalk here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'spacewalk':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class spacewalk (

$db_backend           = $spacewalk::params::db_backend,
$postgresql_embedded  = $spacewalk::params::postgresql_embedded,
$db_user              = $spacewalk::params::db_user,
$db_password          = $spacewalk::params::db_password,
$db_host              = $spacewalk::params::db_host,
$db_port              = $spacewalk::params::db_port,
$admin_email          = $spacewalk::params::admin_email,
$configure_apache_ssl = $spacewalk::params::configure_apache_ssl,
$ca_cert_password     = $spacewalk::params::ca_cert_password,
$ca_organization      = $spacewalk::params::ca_organization,
$ca_organization_unit = $spacewalk::params::ca_organization_unit,
$ca_email_address     = $spacewalk::params::ca_email_address,
$ca_city              = $spacewalk::params::ca_city,
$ca_state             = $spacewalk::params::ca_state,
$ca_country_code      = $spacewalk::params::ca_country_code,
$enable_tftp          = $spacewalk::params::enable_tftp,

) inherits spacewalk::params {

  include spacewalk::packages
}
