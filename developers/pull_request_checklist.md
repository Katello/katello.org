---
layout: documentation
title: Pull Request Checklist
sidebar: sidebars/developer_guide.html
---

# Pull Request Checklist

Here is a checklist to help you know when your PR is ready and when a PR can be merged. If you have
any problems, feel free to [contact a developer](TODO).

## Before you open a PR

* Does your code meet the standards of our styleguides?
  * [Ruby styleguide](TODO)
  * [Javascript styleguide](TODO)
* Does your code have [tests](TODO)?
* Did you [update the katello.org documentation](TODO)?
* Are your strings [properly internationalized](TODO)?
* For API changes, did you update the apidoc?
* Did you leave any commented out code that is no longer needed?
* Are any gems you added properly packaged as RPMs?
* Do your git commit messages...
  * Properly explain the problem and the fix?
  * Reference a [Redmine issue](http://projects.theforeman.org/projects/katello/issues)?
  * Reference a Bugzilla issue (if there is one)?
  * Properly Format [commit messages](/docs/developer_guide/style/git_commit_messages.html)?
* Did you remove any unnecessary commits like merge commits?

## Automation

The following are things that are required as part of a successful pull request. However, they are
[checked by by our automated build tool, Jenkins](TODO). Jenkins should automatically test your PR
once it's open.

* Do the ruby tests pass?
* Do the javascript tests pass?
* Does the linters pass?
* Does the RPM compile?

If these all pass successfully, then your PR should be green at which point it can be reviewed by
another developer.

## Before merging a PR

* Are there any comments that haven't been addressed?
* Did someone "ACK" the PR?
* Is the PR still green?
