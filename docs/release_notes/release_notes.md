---
layout: documentation
title: Release Notes
sidebar: sidebars/documentation.html
---

# Katello 2.2 (Maibock) Release Notes

{% if site.version && site.version != 'nightly' %}
For the full release notes, see the [Changelog](https://github.com/Katello/katello/blob/KATELLO-{{ site.version }}/CHANGELOG.md).
{% else %}
For the full release notes, see the [Changelog](https://github.com/Katello/katello/blob/master/CHANGELOG.md).
{% endif %}

## Features

### Incremental Updates

In Katello 2.1 we provided a first look at incremental updates via the API. With the 2.2 release, incremental updates can be applied via the API, UI and CLI. Incremental updates are applying errata, packages or puppet modules to a content view which produces a minor version of that content view version. The updated version can then be pushed out to all the environments that the major version exists in, thereby making small updates available to any hosts that are using that particular major version of the content view. Users can perform incremental errata updates by visiting the errata index page and using either the bulk actions or viewing the details of an individual errata and clicking on the 'Content Hosts' tab. Package and puppet module updates can be done via the API and CLI.

See the [Errata User Guide](http://www.katello.org/docs/2.2/user_guide/errata/index.html#applying-errata) for more information.

### Isolated Capsules

The end goal is for all client communication to be able to go through a Capsule server. Isolating communication through the Capsule prevents the client from needing network connectivity to the Katello server. With a fully configured Capsule, Hosts would boot and get their IP information from the Capsule’s DHCP server, PXE boot from the Capsule’s tftp server, resolve hostnames using the Capsule’s DNS server, provision from kickstart trees that have been synced to the Capsule, configure itself using the Puppet Master running on the Capsule, and receive content updates directly from the Capsule itself.

See the [Capsules User Guide](http://www.katello.org/docs/2.2/user_guide/capsules/index.html) for more information.

### Docker

Katello 2.2 adds more Docker functionality to the initial set of features provided in 2.1. With 2.2, users can now retreive Docker content from a variety of sources such as Docker hub, private Docker registries, the Red Hat CDN, etc. Docker content can then be published and promoted via Content Views and then pulled or proivisioned to a server running Docker. Docker content can then be inspected at the repository, environment and content view level by viewing the details of each. Further, the Docker Tags page provides an overview of all Docker content within an organization.

See the [Docker User Guide](http://www.katello.org/docs/2.2/user_guide/docker/docker.html) for more information.

## Contributors

Adam Price <komidore64@gmail.com>
Adam Ruzicka <aruzicka@redhat.com>
Brad Buckingham <bbuckingham@redhat.com>
Bryan Kearney <bkearney@redhat.com>
Christine Fouant <cfouant@redhat.com>
Daniel Lobato García <elobatocs@gmail.com>
David Davis <daviddavis@redhat.com>
Dustin Tsang <dtsang@redhat.com>
Eric D. Helms <ericdhelms@gmail.com>
Ivan Nečas <inecas@redhat.com>
Justin Sherrill <jsherril@redhat.com>
Lukas Zapletal <lzap+git@redhat.com>
Marek Hulan
Mike McCune <mmccune@redhat.com>
Ori Rabin <orabin@redhat.com>
Partha Aji <paji@redhat.com>
Stephen Benjamin <stbenjam@redhat.com>
Steve Loranz <sloranz@xantham.com>
Tom McKay <thomasmckay@redhat.com>
Walden Raines <walden@redhat.com>
