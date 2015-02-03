---
layout: documentation
title: Capsule Upgrade
sidebar: sidebars/documentation.html
---

# Capsule Upgrade

Katello supports upgrades from version 2.0.  For users transitioning from 1.4, please see - [Transition Guide](/docs/installation/2.0-transition.html).

## Step 1 - Operating System

Ensure your operating system is fully up-to-date:

```
# yum -y update
```

## Step 2 - Repositories

Update the Foreman and Katello release packages:

  * RHEL6 / CentOS 6:

```
  # yum update -y http://fedorapeople.org/groups/katello/releases/yum/2.1/katello/RHEL/6Server/x86_64/katello-repos-latest.rpm
  # yum update -y http://yum.theforeman.org/releases/1.7/el6/x86_64/foreman-release.rpm
```

  * RHEL7 / CentOS 7:

```
  # yum update -y http://fedorapeople.org/groups/katello/releases/yum/2.1/katello/RHEL/7Server/x86_64/katello-repos-latest.rpm
  # yum update -y http://yum.theforeman.org/releases/1.7/el7/x86_64/foreman-release.rpm
```

## Step 3 - Update Packages

Clean the yum cache

```
# yum clean all
```

Katello-installer has been replaced with capsule-installer in this release, so install this new package:

```
# yum remove katello-installer
# yum install capsule-installer
```

Restore your configuration files:

```
# cp /etc/katello-installer/answers.capsule-installer.yaml.rpmsave /etc/capsule-installer/answers.capsule-installer.yaml
```

Update packages:

```
# yum update -y
```

## Step 4 - Run Installer

The installer with the --upgrade flag will run the right database migrations for all component services, as well as adjusting the configuration to reflect what's new in Katello {{ site.version }}

```
# capsule-installer --upgrade
```

**Congratulations! You have now successfully upgraded your Capsule to {{ site.version }}! For a rundown of what was added, please see [release notes](/docs/{{ site.version }}/release_notes/release_notes.html).**

If for any reason, the above steps failed, please review /var/log/capsule-installer/capsule-installer.log -- if any of the "Upgrade step" tasks failed, you may try to run them manaully below to aid in troubleshooting.

## Manual Steps

**Pulp**

```
# sudo -u apache pulp-manage-db
```

