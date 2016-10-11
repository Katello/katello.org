---
layout: documentation
title: GitHub Workflow
sidebar: sidebars/developer_guide.html
---

# GitHub Workflow

We use git for version control and GitHub to help us manage our git repos. This document is a high-level summary about how we as an organization use GitHub.

## Contributing Code

Anyone can to contribute to Katello. In order to contribute, you should open a new pull request for the relevant repo on GitHub.

To get started, first sign up for a GitHub account if you don't already have one. Then visit the repository you'd like to work on (e.g. https://github.com/Katello/katello) and fork it to your account.

Be sure to branch locally in git and then once your changes are made, commit your changes and push back to your GitHub repo. Once you've pushed, open a new pull request either through the web interface or by using [hub](https://github.com/github/hub).

By default, we develop new code in the master branch. If we are working on large features, we sometimes create separate branches but by default code will most likely be merged to master.

For more information about preparing your pull request and what guidelines your code must meet, see [our PR checklist](/developers/pull_request_checklist.html).

## Contributor Access

When starting out, contributors are added to our "Contributors" team. This allows their pull requests to automatically be run by Jenkins. If you wish to be added to this list, please email [our develop mailing list](https://groups.google.com/forum/#!forum/foreman-dev) or contact a developer via [#theforeman-dev on IRC](http://theforeman.org/support.html#IRC).

## Write Access

Various [teams](https://github.com/orgs/Katello/teams) exist within the Katello GitHub organization who are responsible for maintaining repos in their team's purview. These teams are in areas like Installer, UI, Core, Pulp, etc.  To be added to a team with commit access, contributors should demonstrate proficiency with git, GitHub, and also meet the following criteria within the scope of the team they wish to join:

* One month since first pull request
* Must have 3 or more merged pull requests
* Must have reviewed 3 or more pull requests

We prefer that one of the merged pull requests be a non-trivial bug or feature but we'll consider anyone with three pull requests. If you meet these criteria, please email [our develop mailing list](https://groups.google.com/forum/#!forum/foreman-dev) or contact a developer via [#theforeman-dev on IRC](http://theforeman.org/support.html#IRC)).

Write access will be revoked for inactive members and is subject to being revoked at any time for any reason. Granting write access is also subject to approval from existing team members.

## Owner Access

Owners are people that can add and remove other people from our Katello team structure and add additional git repositories to the Katello org. This access is granted to a subset of people with commit access and is added and removed on a case by case basis.
