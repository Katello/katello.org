---
layout: documentation
title: Katello Upgrade
sidebar: sidebars/documentation.html
---

# Katello Upgrade

Katello supports upgrades from version 2.0.  For users transitioning from 1.4, please see - [Transition Guide](/docs/{{ site.version }}/installation/2.0-transition.html).


# Pre-upgrade considerations

Katello 3.0 unifies Host and Conent Host objects to provide a more unified experience.  As a result, it is no longer allowed to have more than one Content Host with the same FQDN.  This matches the requirement that is already imposed on the Foreman Host object.  Upon upgrade to Katello 3.0 any Hosts that violate one of three rules will be deleted:

* More than one Content Host cannot exist with the same FQDN (all but the most recently registered will be deleted upon upgrade)
* Content Hosts must have a reported FQDN
* If a Host and a Content Host exist with the same FQDN, they must be within the same Organization.

Before upgrading if you would like to see a report of which Content Hosts will be deleted, a script is available as part of Katello 2.4.2.  To run the report run:

```
foreman-rake katello:preupgrade_content_host_check
```

The command will print the number of Content Hosts that will be deleted upon upgrade and generate a csv with the full list including the uuid, name, last checkin date, and a reason for their deletion.

# Upgrade Caveat

At the time of release, upgrades don't properly copy exsting installer configuration to the new scenario based installer. The fix for this is in the installer library Kafo version 0.7.4 which won't be released until Foreman 1.11.3 is released. IF you are planning to do an upgrade you have two options:

  1. Wait for Foreman 1.11.3 and rubygem-kafo-0.7.4
  2. Install Kafo 0.7.4 from our Koji prior to upgrading any other RPMs
    * el7: [rubygem-kafo-0.7.4-1.el7](http://koji.katello.org/packages/rubygem-kafo/0.7.4/1.el7/noarch/rubygem-kafo-0.7.4-1.el7.noarch.rpm)
    * el6: [rubygem-kafo-0.7.4-1.el6](http://koji.katello.org/packages/rubygem-kafo/0.7.4/1.el6/noarch/rubygem-kafo-0.7.4-1.el6.noarch.rpm)

If you have any further questions please reach out to us on IRC or the user mailing list prior to upgrading.

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
  # yum update -y http://yum.theforeman.org/releases/{{ site.foreman_version }}/el6/x86_64/foreman-release.rpm
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
# yum update -y foreman-release-scl
# yum -y update
```

## Step 5 - Run Installer

The installer with the --upgrade flag will run the right database migrations for all component services, as well as adjusting the configuration to reflect what's new in Katello {{ site.version }}

```
# foreman-installer --scenario katello --upgrade
```

**Congratulations! You have now successfully upgraded your Katello to {% if site.version %}{{ site.version }} For a rundown of what was added, please see [release notes](/docs/{{ site.version }}/release_notes/release_notes.html).{% else %}the latest nightly{% endif %}!**


If for any reason, the above steps failed, please review /var/log/foreman-installer/katello.log -- if any of the "Upgrade step" tasks failed, you may try to run them manaully below to aid in troubleshooting.
