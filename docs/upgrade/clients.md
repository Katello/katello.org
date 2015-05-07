---
layout: documentation
title: Client Upgrade
sidebar: sidebars/documentation.html
script: osmenu.js
---

# Client Upgrade

When upgrading clients there are 2 scenarios: manually added clients and provisioned clients.

## Step 1 - Update Repositories

### Manually Added Clients

Update the Katello client release packages:

<p>
  Select your Operating System:
  <select id="operatingSystems">
     <option value="el5">Enterprise Linux 5 (CentOS, etc.)</option>
     <option value="el6">Enterprise Linux 6 (CentOS, etc.)</option>
     <option value="el7">Enterprise Linux 7 (CentOS, etc.)</option>
     <option value="fc20">Fedora 20</option>
     <option value="fc21">Fedora 21</option>
  </select>
</p>

<div id="el5" markdown="1">
```bash
yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/client/RHEL/5Server/x86_64/katello-client-repos-latest.rpm
```
</div>

<div id="el6" style="display:none;" markdown="1">
```bash
yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/client/RHEL/6Server/x86_64/katello-client-repos-latest.rpm
```
</div>

<div id="el7" style="display:none;" markdown="1">
```bash
yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/client/RHEL/7Server/x86_64/katello-client-repos-latest.rpm
```
</div>

<div id="fc20" style="display:none;" markdown="1">
```bash
yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/client/RHEL/Fedora/20/x86_64/katello-client-repos-latest.rpm
```
</div>

<div id="fc21" style="display:none;" markdown="1">
```bash
yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/client/RHEL/Fedora/21/x86_64/katello-client-repos-latest.rpm
```
</div>

### Provisioned Clients

If the katello-agent was setup during proviosioning from a locally synced repository then you will need to go through some [initial setup](/docs/{{ site.version }}/installation/clients.html) to add the {{ site.version }} client repositories to your Katello for each version needed. After you create the new repositories, they will then need to be added to the relevant content view(s) and the older versions removed. At this point, a new version of the content view can be published and promoted to the appropriate environments. Once the new package is available the clients can be updated following the next steps.

## Step 2: Update Packages

Clean the yum cache

```
# yum clean all
```

Update packages:

```
# yum update katello-agent
```
