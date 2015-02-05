---
layout: documentation
title: "Style Guide: Commit Messages"
sidebar: sidebars/developer_guide.html
---

# Git Commit Messages

For Katello, we ask that git commit messages are properly formatted and that they reference an issue
in Redmine. If your change also involves a Bugzilla issue, you must include the Bugzilla number as
well (see the [Bugzilla section](#bugzilla)).

### Format

Git commit messages should give a brief overview of the problem or feature along with a short
description of what was implemented to fix the bug or feature. Well formatted git commit messages
have two components: a short message and a long message or description.  The short message ought to
be limited to 70 characters while the long message should be wrapped at 74 or so characters.  See
below for an example. Also, you can read [Tim Pope's article about git message
formatting](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).

### Redmine

Each git commit message should contain a reference to the Redmine issue at the beginning of the
commit message. There are two way to do this. The first will simply attach the commit to the Redmine
issues:

```
Refs #123 - Improve performance of content views
```

The second type will actually close out the issue once the PR containing the commit gets merged:

```
Fixes #123 - Fix content view publish bug
```

### Bugzilla

If you issue also involves a Bugzilla bug, add the Bugzilla number prefixed by `BZ` to your commit's
short message. For example:

```
Fixes #1234  - Fixes issue with foo bar BZ888342
```

## Example

Below is an example of how a git commit message ought to look like:

```
Fixes #1234 - Fix content view yum publish bug

Fix a problem where content views were not being published if they
contained yum repositories. The repositories were not being referenced
correctly. To fix this, I changed the repository look up method to go to
ElasticSearch and find the attached repos.

This fix also addresses a problem with promoting that was also caused by
this bug. Promoting also has another bug though that needs to be fixed
before it works correctly.
```

## Multi issue example

Below is an example of a pull request fixing multiple issues (pull requests should only fix a single issue in most cases)

```
Fixes #1234,#5678 - Fix content view yum publish bug

Fix a problem where content views were not being published if they
contained yum repositories. The repositories were not being referenced
correctly. To fix this, I changed the repository look up method to go to
ElasticSearch and find the attached repos.
```
