---
layout: documentation
title: Release Notes
sidebar: sidebars/documentation.html
---
# Katello 2.2.1 (Maibock) Release Notes

## Features 

### Documentation
 * Add documentation on how to use Docker ([#9601](http://projects.theforeman.org/issues/9601), [ffdda4f3](http://github.com/katello/katello.org/commit/ffdda4f3b0c8ae4c868481cce1c7ec7d9b528c9d))

## Bug Fixes 

### Web UI
 * katello fails when content host registers with a release version or uploading facts ([#10523](http://projects.theforeman.org/issues/10523), [86973983](http://github.com/katello/katello/commit/86973983e0e615661e697f9f106b9ace6eecfd40))
 * Custom repositories do not define 'metadata_expire = 1' ([#10495](http://projects.theforeman.org/issues/10495), [78c75ae8](http://github.com/katello/katello/commit/78c75ae85c8a5752de9e655f1ec278f492f95245))
 * Product -> Repository page is slow (10-30 seconds) to render when there are 10+ repos with content synced ([#10381](http://projects.theforeman.org/issues/10381), [e179a600](http://github.com/katello/katello/commit/e179a60018fe0cdb951342bd44cf6327ecc45c20))
 * Bulk Actions -> Errata page does not load ([#10309](http://projects.theforeman.org/issues/10309), [ecbb51bc](http://github.com/katello/katello/commit/ecbb51bca629a6c90c8e0528cb62f6dd238d4654))
 * The Content Hosts page is loading very slowly on Satellite 6 ([#10152](http://projects.theforeman.org/issues/10152), [20fecb64](http://github.com/katello/katello/commit/20fecb6490a200a7ac8bba577068d7d7b51b3902))

### Installer
 * GPG key urls not updated on upgrade from 2.1 -> 2.2 ([#10512](http://projects.theforeman.org/issues/10512), [bc091d97](http://github.com/katello/katello-installer/commit/bc091d97eef4b1151c9bbc89e0b6f75414004d01))

### CLI
 * hammer content-host errata list failed ([#10499](http://projects.theforeman.org/issues/10499), [e1fbd2f6](http://github.com/katello/hammer-cli-katello/commit/e1fbd2f60ec2d65775f1cf3dfa5f902a40abcafd))

### Capsule
 * Unable to sync capsule: "undefined method `fetch' for nil:NilClass" ([#10422](http://projects.theforeman.org/issues/10422), [d575025f](http://github.com/katello/katello/commit/d575025fe14e2c2cf91f1878a518ad3a6e80189c))
 * Repeated crashes of goferd on Pulp Node Capsule when trying to SyncNode  ([#10148](http://projects.theforeman.org/issues/10148))

### Content Uploads
 * Package Upload via GUI to Products is not updating Info ([#10327](http://projects.theforeman.org/issues/10327))

### Pulp
 * "undefined method `[]' for nil:NilClass (NoMethodError)" problem synching repo's ([#10231](http://projects.theforeman.org/issues/10231))

### Packaging
 * Katello-agent is not available for Fedora 21 ([#10224](http://projects.theforeman.org/issues/10224), [60b72b76](http://github.com/katello/katello/commit/60b72b762064540a072329c50be54d58613aa9b5))

### Documentation
 * katello.org is missing information about katello-agent ([#7735](http://projects.theforeman.org/issues/7735))

### Other
 * katello-service package doesn't have katello-service ([#10428](http://projects.theforeman.org/issues/10428), [95f1e0cc](http://github.com/katello/katello/commit/95f1e0cc6e2b3ff9877ce2d3f8b2203512ab2296))
 * Can't delete Lifecycle Environment when hosts are assigned to Content View ([#10331](http://projects.theforeman.org/issues/10331), [a0ee7b07](http://github.com/katello/katello/commit/a0ee7b07c00459577be5cac79c105cad5a73733c))


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
