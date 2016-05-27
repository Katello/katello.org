---
layout: base
title: "Development Installation"
sidebar: sidebars/!VERSION!/documentation.html
---

# Development Installation

Katello provides a puppet based installer for deploying development environments. Development deployments are supported on the following OSes:

| OS        | Development |
|-----------|-------------|
| CentOS 6  |      X      |
| RHEL 6    |      X      |
| Fedora 19 |      X      |

There are two methods to install a development setup: direct or [katello-deploy](#katello-deploy).

### Direct Install

A development environment may be setup through the `katello-devel-installer` if you have already deployed a system with one of the supported OSes. Begin by installing the RPM or cloning the `katello-installer`:

**RPM (example using RHEL6)**
```
yum -y localinstall http://fedorapeople.org/groups/katello/releases/yum/nightly/el6/x86_64/katello-repos-latest.rpm
yum install katello-installer
```

**Git Repo**
```
git clone https://github.com/Katello/katello-installer.git
cd katello-installer
```

The development installer has a variety of options that may be set prior to running the installation.
For example, if you have already created a user on the system or have a preferred user name and password these can be configured.
Options can be configured via the answer file or through command line options when running the installer.

**RPM**
```
vim /etc/katello-installer/answers.katello-devel-installer.yaml
katello-devel-installer --help
katello-devel-installer <options>
```

**Git**
```
vim config/answers.katello-devel-installer.yaml
./bin/katello-devel-installer --help
./bin/katello-devel-installer <options>
```

## Katello Deploy

Katello provides a git repository designed to streamline setup by setting up all the proper repositories.
Katello deploy provides the ability to deploy a virtual machine instance via Vagrant or direct deployment on an already provisioned machine.
For details on how to install using katello-deploy, please see the [README](https://github.com/Katello/katello-deploy/blob/master/README.md).

