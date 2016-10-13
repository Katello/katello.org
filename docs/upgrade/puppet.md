---
layout: documentation
title: Puppet Upgrade
sidebar: sidebars/documentation.html
script: osmenu.js
---

# Puppet Upgrade

This document outlines how to upgrade from Puppet 3 to Puppet 4.

##  Overview

Puppet 4 support was added to Foreman in version 1.12, and in Katello in 3.2.  Puppet 4 is a major upgrade from Puppet 3; the changes are too numerous for this document. More information can be found in the [Puppet 3.x to 4.x: Get upgrade-ready](https://docs.puppet.com/puppet/latest/reference/upgrade_major_pre.html) document and the [Puppet 4.0 release notes](https://docs.puppet.com/puppet/4.0/reference/release_notes.html).

Running Puppet 3 and Puppet 4 on the same server is not possible. However, it is possible to run one version of Puppet on your Katello server, and another version of Puppet on one or more capsules. For example, you could have Puppet 4 on your Katello server, Puppet 3 on two capsules, and Puppet 4 on another capsule. The same would work vice-versa, with Puppet 3 on your Katello server and a mix of Puppet 3 and 4 on your capsules.

The upgrade to Puppet 4 will require an outage to your Katello server or capsule, but does not have any long-running data migrations.

### Client Support

When planning your upgrade, keep in mind the following compatbility matrix:

|                 | Puppet 3 Client                                | Puppet 4 Client  |
|-----------------|------------------------------------------------|------------------|
| Puppet 3 Server | Compatible                                     | Not Compatible   |
| Puppet 4 Server | Compatible (requires conf changes on client)   | Compatible       |


When provisioning new clients that should use Puppet 4, set a parameter called 'enable-puppet4' to 'true', so the templates know which package to install and where to place the configuration.  This parameter can be placed at the host, host group, or another appropriate level of the hierarchy.

Further information about Puppet client support is available in the [Puppet documentation](https://docs.puppet.com/puppet/4.0/reference/upgrade_agent.html).

### Syntax changes in Puppet 4

Some older Puppet modules will require syntax updates to be compatible with Puppet 4. For example, if you find that some configuration values on clients are blank after running the Puppet agent, you may need to update your Puppet modules.

##  Upgrading

There are two styles of upgrade. You can either stand up a new capsule that's Puppet 4 and have clients start using it, or upgrade an existing Puppet 3 capsule to Puppet 4. If you do not have an existing capsule and only use the main Katello server, you'll need to upgrade it in-place to take advantage of Puppet 4.

In either upgrade scenario, be sure that you have access to the [Puppet Labs packages](https://docs.puppet.com/puppet/4.6/reference/puppet_collections.html).

###  In-place migration

If you plan on upgrading an existing Katello server or capsule to Puppet 4, the the process is straightforward.

* Take backup or VM snapshot of server
* run `katello-service stop` to stop all services
* run `foreman-installer --upgrade-puppet`. This will perform the upgrade.

The `--upgrade-puppet` option will also restart services. Once it's done, you can either log in again via the web UI, or run `hammer ping` to check service status. If you run `puppet --version` on the server, it should show `4.6.0` or similar.

Note that you cannot use `--upgrade-puppet` and `--upgrade` at the same time.  If you need to do both, run the `--upgrade` first to pull in the latest bugfixes, ensure all services are working as expected, take a new backup, and run `--upgrade-puppet`.

###  New Capsule

If you would rather leave your existing infrastructure in place, you can create a new Puppet 4 capsule, register it to your Katello server, and then have new or existing clients start using that. As long as the Yum repo for Puppet points to the Puppet 4 location, it should automatically pull in Puppet 4. More information is available on the [About Puppet Collections and packages](https://docs.puppet.com/puppet/4.6/reference/puppet_collections.html)
page.

###  Special considerations for "self-registered" Katello installations

Some users have "self-registered" Katello installations, where the system registers to itself to pull content. In this case, you will need to ensure you have synced down the relevant Puppet 4 repositories and subscribed the server to the correct products before starting the upgrade.

The upgrade process will perform any needed package upgrades before commencing configuration changes, so the Katello server should be able to obtain packages from itself before shutting down.

##  Further reading

The [Foreman upgrade notes](http://projects.theforeman.org/projects/foreman/wiki/Upgrading_from_Puppet_3_to_4) contains further notes, including a great "Further reading" area. The Katello installer will automate many of the manual steps, but the Foreman document is a good reference to see what is happening under the covers.
