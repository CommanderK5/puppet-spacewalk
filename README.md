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
}
```

## Reference

###Classes

####Public Classes

* spacewalk: Main class, includes all other classes.
* Spacewalk::repo::server: Manages Spacewalk and Jpackage yum repositories
* spacewalk::repo::client: Manages Spacewalk client yum repositories

####Private Classes

* ntp::package: Handles the packages.
* ntp::setup: Handles the configuration file.
* ntp::service: Handles the service.

## Limitations

Tested on Centos 6.7 and Centos 7.1.

## TODO

* Spacewalk repo and errata sync
* Database setup on extrnal node install 
