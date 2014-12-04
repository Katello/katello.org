---
layout: documentation
title: Installation
sidebar: sidebars/documentation.html
---

# Installation

For development installation instructions see - [development install](/docs/installation/development.html).
For Katello 1.4 users looking for information on how to transition to 2.0, please see - [Transition Guide](/docs/installation/2.0-transition.html).

Note: After installation of Katello, be sure to trust Katello's CA certificate on your system.  This is required for the encrypted NoVNC connections. You will find `katello-default-ca.crt` in the `/pub` directory of your Katello server (e.g. `http://katello.example.com/pub/katello-default-ca.crt`).

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
| CentOS 7  |    X    |  X  |
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

Depending on your OS, you may need to take some additional steps to get your environment setup prior to running the setup steps. For all installations the Katello, and Foreman repositories need to be setup along with a few external repositories. For nightlies, replace **2.0** with **nightly**.

### Time Service

The machine should be set up with a valid time service, since several Katello features will not function well if there is minor clock skew.

### RHEL

Depending on the version of RHEL you are installing on, you'll need to perform the following:

**RHEL6**

```bash
yum -y  --disablerepo="*" --enablerepo=rhel-6-server-rpms install yum-utils wget
yum-config-manager --disable "*"
yum-config-manager --enable rhel-6-server-rpms epel
yum-config-manager --enable rhel-6-server-optional-rpms
```

**RHEL7**

```bash
yum -y  --disablerepo="*" --enablerepo=rhel-7-server-rpms install yum-utils wget
yum-config-manager --disable "*"
yum-config-manager --enable rhel-7-server-rpms epel
yum-config-manager --enable rhel-7-server-optional-rpms
yum-config-manager --enable rhel-7-server-extras-rpms
```

### Enteprise Linux

For all variations of enterprise linux (CentOS and RHEL) the following steps need to be taken:

**EL6**

```bash
yum -y localinstall http://fedorapeople.org/groups/katello/releases/yum/2.0/katello/RHEL/6Server/x86_64/katello-repos-latest.rpm
yum -y localinstall http://yum.theforeman.org/releases/1.6/el6/x86_64/foreman-release.rpm
yum -y localinstall http://mirror.pnl.gov/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y localinstall http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
wget http://dev.centos.org/centos/6/SCL/scl.repo -O /etc/yum.repos.d/scl.repo
```

**EL7**

```bash
yum -y localinstall http://fedorapeople.org/groups/katello/releases/yum/2.0/katello/RHEL/7Server/x86_64/katello-repos-latest.rpm
yum -y localinstall http://yum.theforeman.org/releases/1.6/el7/x86_64/foreman-release.rpm
yum -y localinstall http://mirror.pnl.gov/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
yum -y localinstall http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
yum -y localinstall https://www.softwarecollections.org/en/scls/rhscl/v8314/epel-7-x86_64/download/rhscl-v8314-epel-7-x86_64.noarch.rpm
yum -y localinstall https://www.softwarecollections.org/en/scls/rhscl/ruby193/epel-7-x86_64/download/rhscl-ruby193-epel-7-x86_64.noarch.rpm
```

### Install

After setting up the appropriate repositories, install Katello:

```bash
yum -y install katello
```

At this point the `katello-installer` should be available to setup the server. The installation may be customized, to see a list of options:

```bash
katello-installer --help
```

These may be set as command line options or in the answer file (/etc/katello-installer/answers.katello-installer.yaml). Now run the options:

```bash
katello-installer <options>
```

## Katello Deploy

Katello provides a git repository designed to streamline setup by setting up all the proper repositories. Katello deploy provides the ability to deploy a virtual machine instance via Vagrant or direct deployment on an already provisioned machine. For details on how to install using katello-deploy, please see the [README](https://github.com/Katello/katello-deploy/blob/master/README.md).

