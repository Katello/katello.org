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
     <option value="fc23">Fedora 23</option>
  </select>
</p>

<div id="el5" markdown="1">
```bash
yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/client/el5/x86_64/katello-client-repos-latest.rpm
```
</div>

<div id="el6" style="display:none;" markdown="1">
```bash
yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/client/el6/x86_64/katello-client-repos-latest.rpm
```
</div>

<div id="el7" style="display:none;" markdown="1">
```bash
yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/client/el7/x86_64/katello-client-repos-latest.rpm
```
</div>

<div id="fc23" style="display:none;" markdown="1">
```bash
yum update -y http://fedorapeople.org/groups/katello/releases/yum/{{ site.version }}/client/fc23/x86_64/katello-client-repos-latest.rpm
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
