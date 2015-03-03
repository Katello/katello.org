---
layout: documentation
title: Capsules 
sidebar: sidebars/!VERSION!/documentation.html
---

# Capsules

## What are Capsules?
 The Capsule Server is a separate server that provides services to discover, provision, and configure hosts remotely. The Capsule provides the following features:
        
  * Content delivery (Mirror lifecycle enivronments from your Katello server)
  * DHCP, including ISC DHCP
  * DNS, including Bind and MS DNS servers
  * Any UNIX-based TFTP server
  * Puppet Master servers from 0.24
  * Puppet CA to manage certificate signing and cleaning
  * Baseboard Management Controller (BMC) for power management 

Not all of these features need to be deployed onto a Capsule, as they are all optional.  For example, if in a particular network segment dhcp and dns are managed already (possibly by another group) and you only want the content mirroring capability, you can deploy a Capsule with just the content delivery portion.  

The end goal is for all client communication to be able to go through a Capsule server.  Isolating communication through the Capsule prevents the client from needing network connectivity to the Katello server.  There are still a few cases where clients need to communicate directly to the Katello server, but we hope to close those gaps in future releases. 

With a fully configured Capsule, Hosts would boot and get their IP information from the Capsule's DHCP server, PXE boot from the Capsule's tftp server, resolve hostnames using the Capsule's DNS server, provision from kickstart trees that have been synced to the Capsule, configure itself using the Puppet Master running on the Capsule, and recieve content updates directly from the Capsule itself.

## Deployment

Most deployments would have a single Katello server with multiple Capsules attached.  You may want to deploy a Capsule into each data center, or into each region where there are systems you wish to manage.  Capsules can also be used to scale the number of systems attached to a single Katello server.  

For example, if you have two small data centers hosting 1000 systems and one very large data center hosting 10,000 systems you would likely want to deploy one Capsule server into each of your small data centers and then 2 or more Capsules into your large data center.

## How do Capsules differ from Smart Proxies?

If you are familiar with a Foreman Smart Proxy a Capsule is very similar but adds the content mirroring capabilities of yum and puppet content.  You may see the term Capsule and Smart Proxy used interchangeably.

## What is the default Capsule?

On every Katello server a Capsule is installed by default with only the Puppet Master feature enabled.  This feature is required to be enabled for proper use of Puppet content within Katello.

There is no 'content mirroring' capability of the default Capsule since Katello already hosts the content locally.

## Hardware Requirements

The Capsule server is only supported on x86_64 Operating Systems

 * 2 Two Logical CPUs
 * 4 GB of memory
 * Disk space usage is similar to that of the main Katello server [Installation](./installation.html)


## Required Ports

The following ports need to be open to external connections:

* 80 TCP - HTTP, used for provisioning purposes
* 443 TCP - HTTPS, used for web access and api communication
* 9090 TCP - HTTPS - used for communication with the smart proxy

## Installation

### Preparing the Capsule server

The same yum repositories need to be configured on the Capsule server as the main Katello server.  See the installation guide for the [list of required repositories](/docs/{{ site.version }}/installation/index.html#required-repositories).

### Install needed packages:

yum install -y katello-installer

### Generate Certificates for the Capules

Prior to installing the Capsule we need to generated certificates on the main **Katello** server:

```
capsule-certs-generate --capsule-fqdn "mycapsule.example.com"\
                       --certs-tar    "~/mycapsule.example.com-certs.tar"
```

Replacing 'mycapsule.example.com' with your Capsule's fully qualified domain name.  This will generate a tar file containing all the needed certificates.  You will need to transfer those certificates to the server that you will install your Capsule on using whatever method you prefer (e.g. SCP).

The capsule-certs-generate command will output needed information for the next step. For example:

```
Installing             Done                                               [100%] [.....................]
  Success!

  To finish the installation, follow these steps:

  1. Ensure that the capsule-installer is available on the system.
     The capsule-installer comes from the katello-installer package and
     should be acquired through the means that are appropriate to your deployment.
  2. Copy ~/mycapsule.example.com-certs.tar to the system mycapsule.example.com
  3. Run the following commands on the Capsule (possibly with the customized
     parameters, see capsule-installer --help and
     documentation for more info on setting up additional services):

  rpm -Uvh http://katello-centos6-2.0.example.com/pub/katello-ca-consumer-latest.noarch.rpm
  subscription-manager register --org "ACME_Corporation"
  capsule-installer --parent-fqdn          "katello.example.com"\
                    --register-in-foreman  "true"\
                    --foreman-oauth-key    "EwZePUX7erQeYbuMqytLCd4jHndY5iH4"\
                    --foreman-oauth-secret "K5TmVVsEmc29DCAscJEnupDmHcQQFdc4"\
                    --pulp-oauth-secret    "7TwngPvBSkJELCAQ4fjEmmY9FUn2UGZJ"\
                    --certs-tar            "~/mycapsule.example.com-certs.tar"\
                    --puppet               "true"\
                    --puppetca             "true"\
                    --pulp                 "true"
  The full log is at /var/log/katello-installer/capsule-certs-generate.log
```

Keep track of the 'foreman-oauth-key' and 'foreman-oauth-secret' (or just copy and paste the entire command).

### Registering the Capsule host

The Capsule needs to be registered with subscription-manager to the Katello server prior to running the installer.  For more information about registering with subscription-manager, see [How is a Content Host registered](../content_hosts/index.html#how-is-a-content-host-registered) 

### Installing

The most common installation options provide Content Mirroring and Puppet Master capabilities. The command printed after generating the certs will do this with no modifications:

```
  capsule-installer --parent-fqdn          "katello.example.com"\
                    --register-in-foreman  "true"\
                    --foreman-oauth-key    "EwZePUX7erQeYbuMqytLCd4jHndY5iH4"\
                    --foreman-oauth-secret "K5TmVVsEmc29DCAscJEnupDmHcQQFdc4"\
                    --pulp-oauth-secret    "7TwngPvBSkJELCAQ4fjEmmY9FUn2UGZJ"\
                    --certs-tar            "~/mycapsule.example.com-certs.tar"\
                    --puppet               "true"\
                    --puppetca             "true"\
                    --pulp                 "true"
```
 
A more complex deployment may have dhcp, dns, and tftp as well. Simply add one or more of these options:

```
                  --dns                  "true"\
                  --dns-forwarders       "8.8.8.8"\
                  --dns-forwarders       "8.8.4.4"\
                  --dns-interface        "eth1"\
                  --dns-zone             "example.com"\
                  --dhcp                 "true"\
                  --dhcp-interface       "eth1"\
                  --tftp                 "true"\`
```



## Associating your Capsule with an Organization and Location

In order to be useful, you will need to associate your Capsule with an Organization and Location.  Navigate to Infrastructure > Smart Proxies and

1. Click on your desired Capsule/Smart Proxy
2. Click on the "Organizations" tab
3. Select the desired Organizations
4. Click "Submit"

Repeat for Locations on the "Locations" tab.  

## Associating your Capsule with a Lifecycle Environment

You can associate your Capsule with a Lifecycle Environment by navigating to Infrastructure > Smart Proxies and

1. Click on your desired Capsule/Smart Proxy
2. Click on the "Lifecycle Environments" tab
3. Select the desired environments
4. Click "Submit"

## Manually syncing your Capsules

You can manually syncronize a Capsule using Hammer:

```
hammer -u admin -p password  capsule content synchronize --name mycapsule.example.com
```

to syncronize only a single Lifecycle Environment:

````
hammer -u admin -p password  capsule content synchronize --name=mycapsule.example.com --environment=Production
```

## Automatic syncing of Capsules

Whenever new content is available within a Lifecycle Environment, whether that be from syncing, publishing a Content View, or promoting a Content View, a Capsule sync is initiated to sync that content to the Capsule.  You can find these tasks under on the Monitor > Tasks page once one of those three actions have completed. 

## Provisioning using a Capsule

You can instruct a Host to use a Capsule for one or more services by setting the following fields on the host itsef:

 * Puppet Master
 * Puppet CA
 * Content Source

Content Source determines where the Host will pull its yum content from.

## Manually configurating a client to use a Capsule

To manually configure a client to use a Capsule for yum content, during registration:

```
subscription-manager register --org="Default_Organization" --environment="Library" --baseurl="https://mycapsule.example.com/pulp/repos"
```

or after a Content Host is already registered:

```
subscription-manager config --rhsm.baseurl="https://mycapsule.example.com/pulp/repos"
```

alternatively you can simply set the 'baseurl' option in /etc/rhsm/rhsm.conf to "https://mycapsule.example.com/pulp/repos".
