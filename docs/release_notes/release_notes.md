---
layout: documentation
title: 2.1 Release Notes
sidebar: sidebars/documentation.html
---

# Katello 2.1 (Winter Warmer) Release Notes

{% if site.version && site.version != 'nightly' %}
For the full release notes, see the [Changelog](https://github.com/Katello/katello/blob/KATELLO-{{ site.version }}/CHANGELOG.md).
{% else %}
For the full release notes, see the [Changelog](https://github.com/Katello/katello/blob/master/CHANGELOG.md).
{% endif %}

For installation and upgrade instructions, see [Install](/docs/{{ site.version }}/installation/index.html) and [Upgrade](/docs/{{ site.version }}/upgrade/index.html).

### Project Versions

* Foreman 1.7
* Pulp 2.5
* Candlepin 0.9

## Features

### Errata Management

All errata within an organization can viewed by visiting the 'Errata' menu item under 'Content'. Clicking on an individual errata will bring up detailed information about the errata including affected packages, severity, description and updated date. A list of repositories the errata exists in is all provided. Users can now see a list of content hosts that an errata is applicable too, and apply the errata to those content hosts directly from the errata details screen. See the [Errata user guide](http://www.katello.org/docs/2.1/user_guide/errata/index.html) for a walkthrough of the new management features.

### Email Notifications

Users can now be opted in to receive errata emails on a daily, weekly or monthly basis. The emails that a user can receive are:

* Katello Host Advisory (Daily/Weekly/Monthly) - A report of all of the Errata applicable to all readable Content Hosts
* Katello Promote Errata - A report generated at Content View promotion time showing what Errata applicable to the Content Hosts within that Content View.
* Katello Sync Errata - A report generated after each Repository sync listing new Errata synced and how many Content Hosts are applicable.

### Docker Support

Docker content can be managed similarly to yum and puppet content. Users can now create Docker repositories that can sync an upstream source or have Docker images uploaded to them directly. The contents of the Docker repository can be viewed and images removed from them. As with any new content type, the Docker repositories can be added to a Content View and promoted through your lifecycle environments to be made available for hosts to pull content from.

### Incremental Updates

Content Views follow a pattern of being vetted and promoted through a set of lifecycle environments to propogate changes. However, sometimes an emergency errata or package needs to be pushed out to a content view version that exists in production. If you followed the normal process, you'd have to globber the versions that are currently being vetted in your development or testing environments. To alleviate this issue, the API now provides the ability to issue an incremental update to a content view version. This update can be a set of errata IDs or packages. The API is only available for this release, while Katello 2.2 will feature full UI and CLI support.

### Custom Puppet Environment Support

Custom puppet environments, that come from your own infrastructure and exist outside a content view, can now be used in conjunction with a lifecycle environment and content view. This change also allows the use of puppet environments from a different content view.

## Contributors

Adam Price <komidore64@gmail.com>
Adam Ruzicka <aruzicka@redhat.com>
Brad Buckingham <bbuckingham@redhat.com>
Bryan Kearney <bryan.kearney@gmail.com>
Christine Fouant <cfouant@redhat.com>
Daniel Lobato <elobatocs@gmail.com>
David Davis <daviddavis@redhat.com>
Dustin Tsang <dtsang@redhat.com>
Eric D. Helms <ericdhelms@gmail.com>
Ivan Nečas <inecas@redhat.com>
Jason Montleon <jmontleo@redhat.com>
Justin Sherrill <jsherril@redhat.com>
Martin Bačovský <martin.bacovsky@gmail.com>
Mike McCune <mmccune@redhat.com>
Ondrej Prazak <oprazak@redhat.com>
Partha Aji <paji@redhat.com>
Shlomi Zadok <shlomi@ben-hanna.com>
Stephen Benjamin <stbenjam@redhat.com>
Steve Loranz <sloranz@xantham.com>
Tom McKay <thomasmckay@redhat.com>
Walden Raines <walden@redhat.com>
