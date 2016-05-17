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

**NOTE**: If kernel packages are updated here (e.g. upgrading el 6.6 to 6.7), you must reboot and ensure the new kernel and SELinux policy is loaded before upgrading Katello.

## Step 2 - Repositories

Update the Foreman and Katello release packages:

  * RHEL6 / CentOS 6:

```
  # yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/katello/RHEL/6Server/x86_64/katello-repos-latest.rpm
  # yum update -y http://yum.theforeman.org/{{ site.foreman_version }}/el6/x86_64/foreman-release.rpm
```

  * RHEL7 / CentOS 7:

```
  # yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/katello/RHEL/7Server/x86_64/katello-repos-latest.rpm
  # yum update -y http://yum.theforeman.org/{{ site.foreman_version }}/el7/x86_64/foreman-release.rpm
```

## Step 3 - Update Packages

Clean the yum cache

```
# yum clean all
```

Update packages:

```
# yum update -y
```

## Step 4 - Regenerate Certificates

On the Katello server, regenerate the certificates tarball for your capsule:

```
# capsule-certs-generate --capsule-fqdn "mycapsule.example.com"\
                         --certs-tar    "~/mycapsule.example.com-certs.tar"
```

And copy them to your capsule:

```
# scp ~/mycapsule.example.com-certs.tar mycapsule.example.com:
```

## Step 5 - Run Installer

The installer with the --upgrade flag will run the right database migrations for all component services, as well as adjusting the configuration to reflect what's new in Katello {{ site.version }}

```
# foreman-installer --scenario capsule --upgrade\
                    --certs-tar ~/mycapsule.example.com-certs.tar\
                    --certs-update-all --regenerate --deploy
```

**Congratulations! You have now successfully upgraded your Capsule to {% if site.version %}{{ site.version }} For a rundown of what was added, please see [release notes](/docs/{{ site.version }}/release_notes/release_notes.html).{% else %}the latest nightly{% endif %}!**

If for any reason, the above steps failed, please review /var/log/foreman-installer/capsule.log -- if any of the "Upgrade step" tasks failed, you may try to run them manaully below to aid in troubleshooting.

## Manual Steps

**Pulp**

```
# sudo -u apache pulp-manage-db
```

There are some packages that are no longer needed by pulp and optionally can be removed.

```
# yum remove -y pulp-nodes-common pulp-nodes-child
```

