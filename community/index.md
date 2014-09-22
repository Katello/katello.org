---
layout: community
title: Community
sidebar: sidebars/community.html
---

# Community

## Support

To get appropriate support, you need to provide sufficient information about your operating system, environment and setup. You can utilize the foreman-debug tool which collects information about your OS, Foreman, Katello, and related components. If you installed from packages, the command is available to root:

    # foreman-debug

If you installed from git, you can find it in the Foreman directory:

    # script/foreman-debug

If you run it without any options, it will collect data, filter out possible passwords or tokens and create a tarball which can be safely handed over to us. We reccomend to attach this to any bug report you file.

### Foreman

For Foreman-specific issues, consult the [Support](http://theforeman.org/support.html) and [Manual](http://theforeman.org/manuals/latest/index.html) pages on [theforeman.org](http://theforeman.org).

### Issue Tracker
We use Redmine to report and track bugs and feature requests, which can be found here: [http://projects.theforeman.org/projects/katello/issues](http://projects.theforeman.org/projects/katello/issues)

### IRC
You can find us on the Foreman IRC channel, #theforeman, on [irc.freenode.net](http://webchat.freenode.net/). For development discussions, there is also #theforeman-dev.

### Mailing Lists
We use the same mailing lists as Foreman, which are available via Google Groups. Much like IRC, we have a general users (support, Q/A, etc) lists and a development list.  For Katello-specific issues, it's best to prefix the subject with `[katello]` to get our attention.

* [foreman-users](https://groups.google.com/forum/?fromgroups#!forum/foreman-users) or email `foreman-users+subscribe@googlegroups.com`
* [foreman-dev](https://groups.google.com/forum/?fromgroups#!forum/foreman-dev) or email `foreman-dev+subscribe@googlegroups.com`

There is also a low-traffic list dedicated to release and security announcements:

* [foreman-announce](https://groups.google.com/forum/?fromgroups#!forum/foreman-announce) or email `foreman-announce+subscribe@googlegroups.com`

## Contribute

## Code

Please see the [Developer Guide](/docs/developer_guide/github_workflow.html) for learning how to setup a development environment, testing, and submitting a pull request to GitHub.

## Other

### User Support

Helping out other users on IRC and the mailing lists is always useful. Frequent problems or questions should be brought up so the wiki can be updated to help future users.

### Translations

The Foreman application and Katello have been translated into a number of languages, which require regular updates as strings are added and changed in each release.  We're also on the lookout for new translations if you speak a language that Foreman isn't yet available for.  Join in the effort on [the Katello](https://www.transifex.com/projects/p/katello/) and [Foreman](https://www.transifex.com/projects/p/foreman/) Transifex projects.
