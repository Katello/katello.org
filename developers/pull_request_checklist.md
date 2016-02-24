---
layout: documentation
title: Pull Request Checklist
sidebar: sidebars/developer_guide.html
---

# Pull Request Checklist

Here is a checklist to help you know when your PR is ready and when a PR can be merged. If you have
any problems, feel free to [contact a developer](/community/index.html#support).

## Before you open a PR

* Does your code meet the standards of our styleguides?
  * [Ruby styleguide](/developers/style/ruby.html)
  * [Javascript styleguide](/developers/style/javascript.html)
* Does your code have [tests](/developers/testing.html)?
* Did you [update the katello.org documentation](http://github.com/katello/katello.org)?
* Are your strings [properly internationalized](/developers/bastion/i18n.html)?
* For API changes, did you update the apidoc?
* Did you leave any commented out code that is no longer needed?
* Are any gems you added properly packaged as RPMs?
* Do your git commit messages...
  * Properly explain the problem and the fix?
  * Reference a [Redmine issue](http://projects.theforeman.org/projects/katello/issues)?
  * Reference a Bugzilla issue (if there is one)?
  * Properly Format [commit messages](/developers/style/git_commit_messages.html)?
* Did you remove any unnecessary commits like merge commits?

## Automation

The following are things that are required as part of a successful pull request. However, they are
checked by by our automated build tool, Jenkins. Jenkins should automatically test your PR
once it's open.

* Do the ruby tests pass?
* Do the javascript tests pass?
* Does the linters pass?
* Does the RPM compile?

If these all pass successfully, then your PR should be green at which point it can be reviewed by
another developer.

## Reviewing and Merging PRs

The Katello team does not have any set rules for who can review a pull request.
Detailed feedback is appreciated, but anyone is welcome to chime in and give
their two cents, even if it's just "worked for me" or "looks good". This
applies for both new PRs and PRs with many comments. If you would like to find
PRs to comment on, check out the list of all open PRs for the Katello project,
or browse around in individual repos. Note that the Katello team does not use
the "Assignee" field, all PRs are considered fair game for
review.

When merging a pull request, first scan through the comments and ensure any
questions or suggestions have been addressed by the author. Next, ensure that
one comment contains "ACK", which is the magic word for indicating a PR is
ready to merge. Other comments like "LGTM", :+1:, or "looks good" are valuable
feedback but only "ACK" will get the PR merged. Finally, ensure that the PR has
passed any automated tests and does not require a rebase.
