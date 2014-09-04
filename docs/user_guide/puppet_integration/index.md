---
layout: documentation
title: Puppet Integration
sidebar: sidebars/documentation.html
---

# Managing Puppet Content

### Importing Puppet Modules from Git

In order to allow users to import puppet modules from Git repositories, Katello
comes with a tool called 'pulp-puppet-module-builder' from the
pulp-puppet-tools rpm. This utility will be available on the Katello server but
it can also be installed on another machine if desired. By running it against a
Git repository, it will checkout the repository, build all of the modules, and
publish them in a structure Katello can synchronize against.

The most common method is to run the utility on the Katello server itself and
publish to a localfile system directory sync against that directory.

```bash
mkdir /modules
chmod 755 /modules
pulp-puppet-module-builder --output-dir=/modules --url=git@mygitserver.com:mymodules.git --branch=develop
```

This will checkout the 'develop' branch of the Git repository located at
'git@mygitserver.com:mymodules.git' and publish them to the `/modules`
directory. Then from within Katello, simply set the url on your Puppet
Repository to 'file://modules'. Then you can sync the Repository just like any
other Repository.

If you are running this on a remote machine, then you need to publish the
containing to folder to a location accessible by HTTP or HTTPS.

```bash
mkdir /var/www/html/modules/
chmod 755 /var/www/html/modules/
pulp-puppet-module-builder --output-dir=/var/www/html/modules --url=git@mygitserver.com:mymodules.git --branch=develop
```

Then in Katello, simply enter 'http://HOSTNAME/modules/' for the Repository url
and sync it like you normally would.
