---
layout: community
title: Community Scripts
sidebar: sidebars/community.html
---

# Scripts

## Uploading an RPM with Python
Allows for uploading a single file to a repository.  Can be used as standalone, but provides an excellent example for uploading a package via python. Note this script only works for Katello 3.2+.

Usage:

./upload_file.py --org "Default Organization" --repo tester -u admin -p changeme https://foreman.example.com/  ~/scummvm-1.7.0-2.x86_64.rpm

[Download](./scripts/upload_file.py)

Thanks to tamarin for writing the script!
