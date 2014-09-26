---
layout: documentation
title: Installation
sidebar: sidebars/documentation.html
---

# Installation

For development installation instructions see - [development install](/docs/installation/development.html).
For Katello 1.4 users looking for information on how to transition to 2.0, please see - [Transition Guide](/docs/installation/2.0-transition.html).

## Hardware Requirements

Katello may be installed onto a baremetal host or on a virtual guest.  The minimum requirements are:

* Two Logical CPUs
* 4 GB of memory (8 GB highly recommended)
* The filesystem holding /var/lib/pulp needs to be large, but may vary depending on how many different Operating Systems you wish to syncronize:
  * Allocate 30 GB of space for each operating system.  Even though an operating system may not take up this much space now, this allows space for future updates that will be syncronized later.
* The root filesystem needs at least 20 GB of Disk Space

## Required Ports

The following ports need to be open to external connections:

* 80 TCP - HTTP, used for provisioning purposes
* 443 TCP - HTTPS, used for web access and api communication
* 5671 TCP - qpid ssl - used for client actions
* 9090 TCP - HTTPS - used for communication with the smart proxy

## Production

Katello provides a puppet based installer for deploying production installations. Production installations are supported on the following OSes:

```
| OS        | nightly | 2.0 |
|-----------|---------|-----|
| CentOS 6  |    X    |  X  |
| RHEL 6    |    X    |  X  |
| RHEL 7    |    X    |  X  |
```

Katello can only run on an x86_64 operating systems.

Installation may be done manually or via our recommended approach of using [katello-deploy](#katello-deploy).

**Nightlies**

RPMs of the bleeding edge code are generated every 4 hours and may be installed as a production type installation. We do not recommend nor guarantee the stability of the nightlies. The repository RPMs for nightlies are:

 * RHEL6 / CentOS 6:

       http://fedorapeople.org/groups/katello/releases/yum/nightly/katello/RHEL/6Server/x86_64/katello-repos-latest.rpm

 * RHEL7 / CentOS 7:

       http://fedorapeople.org/groups/katello/releases/yum/nightly/katello/RHEL/7Server/x86_64/katello-repos-latest.rpm

### Setup

Depending on your OS, you may need to take some additional steps to get your environment setup prior to running the setup steps. For all installations the Katello, and Foreman repositories need to be setup along with a few external repositories. To do so, run the following ensuring the replace <INSTALL TYPE> with one of the available types and <OS_VERSION> with your RHEL/CentOS version:

INSTALL_TYPES:
  
  * nightly
  * 2.0

OS_VERSION:

  * 6
  * 7

```
yum -y localinstall http://fedorapeople.org/groups/katello/releases/yum/<INSTALL TYPE>/katello/RHEL/<OS_VERSION>Server/x86_64/katello-repos-latest.rpm
yum -y localinstall http://yum.theforeman.org/<INSTALL TYPE>/el<OS_VERSION>/x86_64/foreman-release.rpm
yum -y localinstall http://mirror.pnl.gov/epel/<OS_VERSION>/x86_64/epel-release-6-8.noarch.rpm
yum -y localinstall http://yum.puppetlabs.com/puppetlabs-release-el-<OS_VERSION>.noarch.rpm
```

#### RHEL

Depending on the version of RHEL you are installing on, you'll need to perform the following and substitute the appropriate version for <VERSION>:

```
yum -y  --disablerepo="*" --enablerepo=rhel-<VERSION>-server-rpms install yum-utils wget
yum-config-manager --disable "*"
yum-config-manager --enable rhel-<VERSION>-server-rpms epel
yum-config-manager --enable rhel-<VERSION>-server-optional-rpms
yum-config-manager --enable rhel-server-rhscl-<VERSION>-rpms
```

#### CentOS

For CentOS 6, you'll need to enable the SCL repo:

```
wget http://dev.centos.org/centos/6/SCL/scl.repo -O /etc/yum.repos.d/scl.repo
```

For CentOS 7, you'll need to include two SCL repos from http://softwarecollections.org:

```
https://www.softwarecollections.org/en/scls/rhscl/v8314/epel-7-x86_64/download/rhscl-v8314-epel-7-x86_64.noarch.rpm
https://www.softwarecollections.org/en/scls/rhscl/ruby193/epel-7-x86_64/download/rhscl-ruby193-epel-7-x86_64.noarch.rpm
```

### Install

After setting up the appropriate repositories, install Katello:

```
yum -y install katello
```

At this point the `katello-installer` should be available to setup the server. The installation may be customized, to see a list of options:

```
katello-installer --help
```

These may be set as command line options or in the answer file (/etc/katello-installer/answers.katello-installer.yaml). Now run the options:

```
katello-installer <options>
```

## Katello Deploy

Katello provides a git repository designed to streamline setup by setting up all the proper repositories. Katello deploy provides the ability to deploy a virtual machine instance via Vagrant or direct deployment on an already provisioned machine. For details on how to install using katello-deploy, please see the [README](https://github.com/Katello/katello-deploy/blob/master/README.md).

