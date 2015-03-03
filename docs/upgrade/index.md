---
layout: documentation
title: Katello Upgrade
sidebar: sidebars/documentation.html
---

# Katello Upgrade

Katello supports upgrades from version 2.0.  For users transitioning from 1.4, please see - [Transition Guide](/docs/{{ site.version }}/installation/2.0-transition.html).

## Step 1 - Backup

If Katello is running on a Virtual Machine, we reccomend to take a snapshot prior to upgrading. Otherwise, take a backup of the relevant databases by following the [instructions here](/docs/{{ site.version }}/user_guide/backup/).

## Step 2 - Operating System

Ensure your operating system is fully up-to-date:

```
# yum -y update
```

## Step 3 - Repositories

Update the Foreman and Katello release packages:

  * RHEL6 / CentOS 6:

```
  # yum update -y http://fedorapeople.org/groups/katello/releases/yum/nightly/katello/RHEL/6Server/x86_64/katello-repos-latest.rpm
  # yum update -y http://yum.theforeman.org/nightly/el6/x86_64/foreman-release.rpm
```

  * RHEL7 / CentOS 7:

```
  # yum update -y http://fedorapeople.org/groups/katello/releases/yum/nightly/katello/RHEL/7Server/x86_64/katello-repos-latest.rpm
  # yum update -y http://yum.theforeman.org/nightly/el7/x86_64/foreman-release.rpm
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
# katello-installer --upgrade
```

**Congratulations! You have now successfully upgraded your Katello to {% if site.version %}{{ site.version }} For a rundown of what was added, please see [release notes](/docs/{{ site.version }}/release_notes/release_notes.html).{% else %}the latest nightly{% endif %}!**


If for any reason, the above steps failed, please review /var/log/katello-installer/katello-installer.log -- if any of the "Upgrade step" tasks failed, you may try to run them manaully below to aid in troubleshooting.

## Manual Steps

**Candlepin**

The database password is stored in /var/lib/puppet/foreman_cache_data/candlepin_db_password.

```
# /usr/share/candlepin/cpdb --update --password <PASSWORD>
```

**Pulp**

```
# sudo -u apache pulp-manage-db
```

**Foreman**

```
# foreman-rake db:migrate
# katello-service restart
# foreman-rake db:seed
```

**Errata import**

```
# foreman-rake katello:upgrades:2.1:import_errata
```
