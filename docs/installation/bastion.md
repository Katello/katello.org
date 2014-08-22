---
layout: documentation
title: "Bastion: Installation"
sidebar: sidebars/documentation.html
---

# Installing Bastion 

When running Katello in a production environment there are no additional steps beyond what's already mentioned in the (Katello Install Guide)[TODO]. 
Setting up a development environment, requires the following additional steps. 

## Setup Development Environment 

There are two ways to install Node.js: via RPMs and nvm. Much like rvm, nvm lets you easily run multiple Node.js versions.
Using nvm is a more advanced setup while the RPM setup is recommended.

### RPM setup 

Install nodejs via the method that corresponds to your particular development environment, for example, on Fedora 18:

    sudo yum install npm

Install the required command line tools globally via npm:

    sudo npm install -g phantomjs bower grunt-cli

### nvm setup

Install [nvm via the repo instructions](https://github.com/creationix/nvm#install-script).

    curl https://raw.githubusercontent.com/creationix/nvm/v0.5.1/install.sh | sh

Next install the latest version of nodejs.

    nvm install 0.10

Close your console, open a new one, and then install the necessary global packages.

    nvm use 0.10
    npm install -g phantomjs bower grunt-cli


### Install Local Packages

Ensure you are in the engines/bastion directory or change to the directory.
Install the local node modules defined within package.json:

    cd ~/path/to/mykatello/engines/bastion
    npm install

Install the JavaScript asset libraries used for testing defined within the `devDependencies` section of bower.json:

    grunt bower:dev

Run 'grunt test' to ensure test setup is working.
