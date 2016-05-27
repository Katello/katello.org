---
layout: documentation
title: 2.0 Release Notes
sidebar: sidebars/!VERSION!/documentation.html
---

# Katello 2.0 (Oktoberfest) Release Notes

For the full release notes, see the [Changelog](https://github.com/Katello/katello/blob/KATELLO-2.0/CHANGELOG.md).

## Features

### Katello as a Plugin

The 2.0 version of Katello brings about a major shift in the architecture. Katello has converted from a stand alone Rails application to a Rails engine and made use of the Foreman plugin infrastructure to integrate itself within the Foreman ecosystem. With this change in architecture, Katello has been able to centralize management of common entities such as users, organizations, authentication and authorization. There is now a single RBAC system using the core model provided by Foreman. Further, there is now a single user interface and thus single navigation structure from which to interact with both Foreman and Katello along with tighter integration as outlined in the section below. Katello has also transitioned the provided CLI to make use of the Hammer project to provide users with a single, seamless CLI interface for interaction. 

The transition to use Foreman as a core for the Katello content pieces has resulted in renaming some Katello entities to better fit within the Foreman ecosystem:

 * Environments are now Lifecycle Environments
 * Systems are now Content Hosts
 * System Groups are now Host Collections

### Pulp 2.4 and Speed Improvements

This release brings along Pulp 2.4 which provides an enhanced tasking system based on the popular Celery project. The combination of this new tasking system and improvements on the Katello side have resulted in net improvements of up to 75% when publishing or promoting a content view. Further, users should no longer experience timeout errors when performing a Katello operation that requires action within Pulp as their new tasking system keeps their API from being over worked.

### UI Improvements

Following work done in Katello 1.4 (systems, products/repositories pages) to transition UI pages into our new design, Katello 2.0 provides new interaction pages for:

 * Lifecycle Environments
 * Subscriptions
 * Activation Keys
 * Sync Plans
 * Content Views
 * Content Hosts
 * Host Collections

### API V2

The API has been completely ported to the V2 specification and all V1 APIs have been entirely removed. In conjunction with Foreman, the Katello V2 API has been standardized with common request and response formats for all operations. Further, the Red Hat Subscription Manager API end points have been moved to their own API end point (/rhsm) since they do not follow the standard API V2 conventions.

### Capsules

Katello 2.0 provides the concept of Capsules that are a combination of federated services on a remote host. A Capsule can allow a user to setup and manage a variety of services that are then geographically local to a particular set of hosts. The Capsule is able to provide any services the base Foreman Proxy can along with Pulp node capabilities.

### Enhanced Orchestration

Under the hood Katello has changed to using a project incubated within Katello called Dynflow. The use of Dynflow has resulted in better orchestration between Katello and the services it interacts with (Pulp, Candlepin and Foreman) when performing operations. Actions that require work to be done across 1 or more backend services can now be split up into tasks that are run sequentially or concurrently. The use of planned tasks allows the user to be presented with a view of the progress of a given operation, as well as some insight into the steps being taken along the way. Further, users can now resume and cancel stuck tasks in some instances.

## Deprecation Warnings

### Removal of the V1 API

The V1 API has been entirely removed in 2.0. API calls to `/katello/api/` will default to the V2 API or can be explicitly hit via `/katello/api/v2`.

### Katello CLI

The original, python-based Katello CLI is no longer maintained and works only against the 1.X line. The old CLI was targeted at the V1 API which was removed in 2.0. Users are encouraged to look at the Hammer CLI Katello project when considering a transition to Katello 2.0 if porting a script over. This new CLI is based around the Hammer CLI project and provides both Katello and Foreman CLI commands in a single CLI.

## Contributors

Adam Price <adprice@redhat.com>
Adam Price <komidore64@gmail.com>
Adam Ruzicka <aruzicka@redhat.com>
Adam Saleh
Adrian Likins
Amos Benari <abenari@redhat.com>
Brad Buckingham <bbuckingham@redhat.com>
Bryan Kearney <bkearney@redhat.com>
Chris Alfonso
Chris Duryee <cduryee@redhat.com>
Christine Fouant <cfouant@redhat.com>
Clifford Perry <cperry@redhat.com>
David Davis <davidd@scimedsolutions.com>
David Davis <daviddavis@redhat.com>
Devan Goodwin <dgoodwin@redhat.com>
Dmitri Dolguikh <dmitri@appliedlogic.ca>
Dmitri Dolguikh <dmitri@redhat.com>
Dominic Cleal <dcleal@redhat.com>
Dustin Tsang <dstywho@gmail.com>
Dustin Tsang <dtsang@redhat.com>
Eric D Helms <ehelms@redhat.com>
Eric D Helms <ericdhelms@gmail.com>
Eric Sammons <elsammons@gmail.com>
Gerhard Stoeckel <gstoecke@redhat.com>
Greg Sutcliffe <gsutclif@redhat.com>
Ivan Nečas <inecas@redhat.com>
Jakub Hadvig <j.hadvig@gmail.com>
Jakub Steiner
Jan Pazdziora
Jason E. Rist <jrist@redhat.com>
Jason L Connor <jason.connor@gmail.com>
Jason Montleon <jmontleo@redhat.com>
Jeff Weiss <jweiss@redhat.com>
Jordan OMara <jomara@redhat.com>
Joseph Magen <jmagen@redhat.com>
Joseph Magen <joseph@isratrade.co.il>
Justin Sherrill <jsherril@redhat.com>
Lukáš Zapletal <lzap+git@redhat.com>
Manjiri Tapaswi <mtapaswi@redhat.com>
Marek Hulan <ares@igloonet.cz>
Marek Hulan <mhulan@redhat.com>
Martin Bačovský <martin.bacovsky@gmail.com>
Martin Bačovský <mbacovsk@redhat.com>
Michael Mraka <michael.mraka@redhat.com>
Michael Stead <mstead@redhat.com>
Michaux Kelley <michauxkelley@gmail.com>
Mike McCune <mmccune@redhat.com>
Miroslav Suchý <msuchy@redhat.com>
Og B. Maciel <ogmaciel@gnome.org>
Og B. Maciel <omaciel@ogmaciel.com>
Ohad Levy <ohadlevy@gmail.com>
Ondrej Prazak <oprazak@redhat.com>
Partha Aji <paji@redhat.com>
Payal Godhani <pgodhani@redhat.com>
Pep Turro Mauri
Petr Chalupa <git@pitr.ch>
Petr Chalupa <pchalupa@redhat.com>
Shannon Hughes <shughes@redhat.com>
Stephen Benjamin <stbenjam@redhat.com>
Stephen Herr <sherr@redhat.com>
Tom McKay <thomasmckay@redhat.com>
Tomas Strachota <tomas.str@gmail.com>
Tomas Strachota <tstrachota@redhat.com>
Tyler Smart <tsmart@redhat.com>
Walden Raines <walden@redhat.com>
