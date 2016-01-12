# spacewalk

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Usage](#usage)
4. [Reference](#reference)
5. [Limitations](#limitations)
6. [TODO](#TODO)

## Overview

The spacewalk module installs and configures Spacewalk server.

## Module Description

The spacewalk module handles installing, configuring, and running Spacewalk server on Redhat based oparting systems.

## Usage

### Install spacewalk server yum repository:

```puppet
include spacewalk::repo::server
```

### Simmilar for client repo:

```puppet
include spacewalk::repo::server
```

### Install spacewalk with defaults (postgresql embedded):

```puppet
class {'spacewalk': }
```
### Spacewalk server with external postgresql db:

```puppet
class { 'spacewalk': 
  db_backend          => postgresql,
  postgresql_embedded => false,
  db_name             => spacedb,
  db_user             => user, 
  db_password         => mypassword,
  db_host             => exampledb.test.com
}
```

### Spacewalk server on Vagrant:

```puppet
class { 'spacewalk': 
  skip_db_diskspace_check_opt => true,
}

## Reference

###Classes

####Public Classes

* spacewalk: Main class, includes all other classes.
* Spacewalk::repo::server: Manages Spacewalk and Jpackage yum repositories.
* spacewalk::repo::client: Manages Spacewalk client yum repositories.

####Private Classes

* ntp::package: Handles the packages.
* ntp::setup: Handles the spacewalk setup utility.
* ntp::service: Handles the service.

###Paramseters

###```service_ensure```

Tells Puppet whether the Spacewalk service should be running. Valid options: 'running' or 'stopped'. Default value: 'running'

###```db_backend```

Database server, Spacewalk supports PostgreSQL (version 8.4 and higher) or Oracle RDBMS (version 10g or higher). Valid options: 'postgrsql' or 'oracle'. Default value: posgtresql

###```postgresql_embedded```

PostgreSQL server, set up by Spacewalk (embedded). Valid options: true or false. Default value: true

###```db_name```

Database name. Default value: spaceschema

###```db_user```

Database username. Default value: spaceuser

###```db_password```

Database password.

###```db_host```

Database host. Default value: localhost

###```db_port```

Database port. Default value: 5432

###```admin_email```

Admin email address. Default value: root@localhost

###```configure_apache_ssl```

Configure apache default ssl server. Valid options: true or false. Default value: true

###```ca_cert_password```

Certificate password

###```ca_organization```

Certificate organization.

###```ca_organization_unit```

Certificate OU.

###```ca_email_address```

Certificate email address.

###```ca_city```

Certificate city.

###```ca_state```

Certificate state.

###```ca_country_code```

Certificate country code.

###```enable_tftp```

Enable tftp and xinetd services needed for Cobbler PXE provisioning functionality. Valid options: true or false. Default value: true.

###```disconnected_opt```

Install the satellite in disconnected mode. Valid options: true or false. Default value: true.

###```re_register_opt```

Register the system with RHN, even if it is already registered. Valid options: true or false. Default value: false.

###```clear_db_opt```

Clear any pre-existing database schema before installing. This will destroy any data in the Satellite database and re-create
empty Satellite schema. This option implies skip_db_install_opt. Valid options: true or false. Default value: false.

###```skip_selinux_test_opt```

For the installation and setup to proceed properly, SELinux should be in Permissive or Enforcing mode. If you are certain that you are not in Disabled mode or you want to install in Disabled anyway, re-run the installer with the flag. Valid options: true or false. Default value: false.

###```skip_db_diskspace_check_opt```

Do not check to make sure there is enough free disk space to install the embedded database. Valid options: true or false. Default value: false.

###```skip_db_install_opt```

Do not install the embedded database. This option may be useful if you are re-installing the satellite, and do not want to clear
the database. Valid options: true or false. Default value: false.

###```skip_fqdn_test_opt```

Do not verify that the system has a valid hostname. Valid options: true or false. Default value: false.

###```skip_db_population_opt```

Do not populate the database schema. Valid options: true or false. Default value: false.

## Limitations

Tested on Centos 6.7 and Centos 7.1.

## TODO

* Spacewalk repo and errata sync.
* Database setup on extrnal node.
