---
layout: documentation
title: Katello Upgrade
sidebar: sidebars/documentation.html
---

# Katello Upgrade

## Step 1 - Backup

If Katello is running on a Virtual Machine, it would be a good idea to take a snapshot prior to upgrading.  Otherwise, take a backup of the relevant databases by following the instructions here (todo).

## Step 2 - Operating System

Ensure your operating system is fully up-to-date:

```
# yum -y update
```

## Step 3 - Repositories

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

## Step 4 - Update Packages

Clean the yum cache

```
# yum clean all
```

Update the packages:

```
# yum install python-crane qpid-cpp-client-devel
# yum -y update
```

## Step 5 - Upgrade Steps

### Use the Installer

The installer with the --upgrade flag will run the right database migrations for all component services, as well as adjusting the configuration to reflect what's new in Katello 2.1

```
# katello-installer --upgrade
```

### Manual Steps

**Using the installer --upgrade flag is the reccomended method,** but if for any reason you need to run the migrations by hand:

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

You will still need to run the katello-installer to ensure all configuration is up-to-date:

```
# katello-installer
```

