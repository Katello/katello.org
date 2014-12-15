---
layout: documentation
title: 2.1 Release Notes
sidebar: sidebars/documentation.html
---

# Katello 2.1 (Winter Warmer) Release Notes

For the full release notes, see the [Changelog](https://github.com/Katello/katello/blob/KATELLO-2.1/CHANGELOG.md).

## Upgrade Instructions

### Capsule

Capsules previously relied on the katello-installer package to provide the capsule-installer. The capsuler-installer has been broken out into it's own package for 2.1 and existing Capsules will require an update. To do so:

1. Install the Katello 2.1 repos file
2. Install the capsule-installer package which removes the katello-installer and saves the capsules configuration and answer files:

    ```
    yum install capsule-installer
    ```

3. Move the original answers file, saved by yum during upgrade, to the new capsule-installer directory:

    ```
    mv /etc/katello-installer/answers.capsule-installer.yaml /etc/capsule-installer/
    ```

## Features

