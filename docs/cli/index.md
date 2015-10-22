---
layout: documentation
title: CLI
sidebar: sidebars/documentation.html
script: osmenu.js
---

# Hammer

## What is the CLI?

The Hammer CLI provides users with a command-line interface for interacting
with Katello. It's our goal to make all functionality that's accessible through
Katello's Web UI also available through Hammer so that users may use Hammer for
their entire Katello workflow.

## Installation

The first step to install the CLI is to setup the appropriate repositories: foreman, katello and epel.

<p>Select your Operating System: <select id="operatingSystems">
   <option value="rhel6">Red Hat Enterprise Linux 6</option>
   <option value="rhel7">Red Hat Enterprise Linux 7</option>
   <option value="el6">Enterprise Linux 6 (CentOS, etc.)</option>
   <option value="el7">Enterprise Linux 7 (CentOS, etc.)</option>
   </select>
</p>
<div id="rhel6" markdown="1">
```bash
yum -y  --disablerepo="*" --enablerepo=rhel-6-server-rpms install yum-utils wget
yum-config-manager --disable "*"
yum-config-manager --enable rhel-6-server-rpms epel
yum-config-manager --enable rhel-6-server-optional-rpms
```
</div>

<div id="el6" markdown="1">
```bash
yum -y localinstall http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/katello/RHEL/6Server/x86_64/katello-repos-latest.rpm
yum -y localinstall http://yum.theforeman.org/{{ site.foreman_versions[site.version] }}/el6/x86_64/foreman-release.rpm
yum -y localinstall http://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
```
</div>

<div id="rhel7" style="display: none;" markdown="1">
```bash
yum -y  --disablerepo="*" --enablerepo=rhel-7-server-rpms install yum-utils wget
yum-config-manager --disable "*"
yum-config-manager --enable rhel-7-server-rpms
yum-config-manager --enable rhel-7-server-optional-rpms
yum-config-manager --enable rhel-7-server-extras-rpms
```
</div>

<div id="el7" style="display: none;" markdown="1">
```bash
yum -y localinstall http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/katello/RHEL/7Server/x86_64/katello-repos-latest.rpm
yum -y localinstall http://yum.theforeman.org/{{ site.foreman_versions[site.version] }}/el7/x86_64/foreman-release.rpm
yum -y localinstall http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```
</div>

After setting up the appropriate repositories, install Katello:

```bash
yum -y install rubygem-hammer_cli_katello
```

## How do I use Hammer?

To get started with hammer, view the help:

    hammer -u <user> -p <password> --help

## How do I contribute to Hammer?

See the [Katello Hammer CLI project](https://github.com/Katello/hammer-cli-katello)
if you want to get setup for contributing to the hammer code.
