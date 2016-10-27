---
layout: documentation
title: Katello Upgrade
sidebar: sidebars/documentation.html
---

# Katello Upgrade

Katello supports upgrades from version 2.0.  For users transitioning from 1.4, please see - [Transition Guide](/docs/{{ site.version }}/installation/2.0-transition.html).


# Pre-upgrade considerations

Before you upgrade, you need to run the upgrade check script that will check for any active tasks, your version of Katello, and if there are any content hosts that will be deleted (see below). This script is included in Katello 2.4.3.

To run the script:

```
foreman-rake katello:upgrade_check
```

## Step 1 - Backup

If Katello is running on a Virtual Machine, we reccomend to take a snapshot prior to upgrading. Otherwise, take a backup of the relevant databases by following the [instructions here](/docs/{{ site.version }}/user_guide/backup/).

## Step 2 - Operating System

Ensure your operating system is fully up-to-date:

```
# yum -y update
```

**NOTE**: If kernel packages are updated here (e.g. upgrading el 6.6 to 6.7), you must reboot and ensure the new kernel and SELinux policy is loaded before upgrading Katello.

## Step 3 - Repositories

Update the Foreman and Katello release packages:

  * RHEL6 / CentOS 6:

```

  # yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/katello/el6/x86_64/katello-repos-latest.rpm
  # yum update -y http://fedorapeople.org/groups/katello/releases/yum/foreman/{{ site.foreman_version }}/el6/x86_64/foreman-release.rpm
```

  * RHEL7 / CentOS 7:

```
  # yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/katello/el7/x86_64/katello-repos-latest.rpm
  # yum update -y http://yum.theforeman.org/releases/{{ site.foreman_version }}/el7/x86_64/foreman-release.rpm
```

## Step 4 - Update Packages

Clean the yum cache

```
# yum clean all
```

Update the required packages:

```
# yum -y update
```

## Step 5 - Run Installer

The installer with the --upgrade flag will run the right database migrations for all component services, as well as adjusting the configuration to reflect what's new in Katello {{ site.version }}

```
# foreman-installer --scenario katello --upgrade
```

**Congratulations! You have now successfully upgraded your Katello to {% if site.version %}{{ site.version }} For a rundown of what was added, please see [release notes](/docs/{{ site.version }}/release_notes/release_notes.html).{% else %}the latest nightly{% endif %}!**


If for any reason, the above steps failed, please review /var/log/foreman-installer/katello.log -- if any of the "Upgrade step" tasks failed, you may try to run them manaully below to aid in troubleshooting.
