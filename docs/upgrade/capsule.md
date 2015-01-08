---
layout: documentation
title: Capsule Upgrade
sidebar: sidebars/documentation.html
---

# Capsule Upgrade

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

We've replaced katello-installer with capsule-installer in these release, so install this new package:

```
# yum remove katello-installer
# yum install capsule-installer
```

Updating remaining packages:

```
# yum update -y
```

## Step 4 - Upgrade Steps

### Use the Installer

The installer with the --upgrade flag will run the right database migrations for all component services, as well as adjusting the configuration to reflect what's new in Katello 2.1

```
# capsule-installer --upgrade
```

### Manual Steps

**Using the installer is the reccomended method,** but if you need to run the migrations by hand:

**Pulp**

```
# sudo -u apache pulp-manage-db
```
