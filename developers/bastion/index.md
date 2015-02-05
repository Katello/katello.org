---
layout: documentation
title: "Bastion: The Katello UI Engine"
sidebar: sidebars/developer_guide.html
---

# Bastion: The Katello UI Engine

Bastion is a single page AngularJS based web client for the Katello server. The bastion plug-in can be found in the [bastion project on GitHub](https://github.com/Katello/bastion)

    app/assets/bastion - application folder for all the JavaScript and view templates
    app/assets/bastion/bastion.js - Rails asset pipeline manifest
    app/assets/bastion/bastion.module.js - master application module that loads up all sub-modules
    app/assets/bastion/stylesheets - stylesheets used for the UI

    lib/bastion - contains the Rails engine definition and initializes to make assets available to Rails

    test/ - contains JavaScript tests broken down by the same structure as the application

    vendor/assets/javascripts - third party JavaScript libraries
    vendor/assets/stylesheets - third party stylesheets
    vendor/assets/fonts - third party fonts

    Gruntfile.js - defines the project tasks that can be run with `grunt` (e.g. `grunt ci`)
    karma.conf.js - JavaScript test configuration for the Karma test runner
    package.json - defines what nodejs modules are needed for development
    bower.json - defines the web assets needed for development and testing

## Single page Application

Bastion is a "single page application".  This means that all Bastion "pages" are served from a single static page without the need for a round trip to the server.
All URLs are relative to the application root, `/content-hosts` and `/content_views`, for example, are able to be bookmarked, and work with the browser's back button.
The only real difference, as far as the user is concerned, is that the application is much quicker between Bastion "page loads" since only the HTML needed to render the next page is loaded instead of the entire page.

### Note on Browser Compatibility

HTML5 session history management is not supported in IE9, Chrome 4.0, Firefox 3.6 and lower.  In these browsers users will continue to see urls with hashes (/bastion/#content-hosts, for example).

## Setup Testing Environment ####

There are two ways to install Node.js: via RPMs and nvm. Much like rvm, nvm lets you easily run multiple Node.js versions. Using nvm is a more advanced setup while the RPM setup is recommended.

## Development Setup

### RPM setup

Install nodejs via the method that corresponds to your particular development environment, for example, on Fedora 18:

```bash
sudo yum install npm
```

Install the required command line tools globally via npm:

```bash
sudo npm install -g phantomjs bower grunt-cli
```

### nvm setup

Install [nvm via the repo instructions](https://github.com/creationix/nvm#installscript).

```bash
curl https://raw.githubusercontent.com/creationix/nvm/v0.5.1/install.sh | sh
```

Next install the latest version of nodejs.

```bash
nvm install 0.10
```

Close your console, open a new one, and then install the necessary global packages.

```bash
nvm use 0.10
npm install -g phantomjs bower grunt-cli
```


### Installing Local Packages

Ensure you are in the engines/bastion directory or change to the directory.
Install the local node modules defined within package.json:

```bash
cd ~/path/to/mykatello/engines/bastion
npm install
```

Install the JavaScript asset libraries used for testing defined within the `devDependencies` section of bower.json:

```bash
bower install
```

Run 'grunt test' to ensure test setup is working.

## Contributing

For code to be accepted upstream, the following conditions must be met:

* All code must be tested
* All code must be linted
* All code must be documented

To help with this, we recommend running the following before opening a pull request:

```bash
grunt ci
```

## Testing

The Bastion JavaScript test suite requires the use of nodejs to be run. Nodejs is currently available for Fedora 18, Fedora 19 and EPEL. See here for more information - https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#fedora

### Requires

The minimum required libraries for running the test suite is the follow (see following section for set up instructions):

* nodejs - JavaScript runtime platform
* npm - package manager for Nodejs libraries
* bower - JavaScript asset manager
* phantomjs - headless webkit browser used for running tests
* grunt-cli - command line tool for running user defined tasks

### Test Commands

The Bastion test suite can either be run as a single test run or as a continuous test server that re-runs all tests whenever a file is updated. The test server also allows a developer to open multiple browsers (e.g. Chrome, Firefox) that the tests are run against in addition to the default PhantomJS browser.

To run a single test:

```bash
grunt test
```

To run the test server:

```bash
grunt test:server
```

To connect a browser to the test server, point your browser to your machine at port `8081`.

## Linting

### JavaScript

To enforce JavaScript guidelines, we use the [JSHint](http://jshint.com/) library via [grunt-contrib-jshint](https://github.com/gruntjs/grunt-contrib-jshint). The configuration being used by the project is located at the root of the Bastion engine in the `.jshintrc` file.

To run the JavaScript linter:

```bash
grunt jshint
```

### HTML

To check HTML code, we use [grunt-htmlhint](https://github.com/yaniswang/grunt-htmlhint) which uses the lint checks from [HTMLHint](http://htmlhint.com/).

To run the HTML linter:

```bash
grunt htmlhint
```

## Code Conventions

 * For Javascript code, see the [Katello Javascript Code Conventions](/developers/style/javascript.html).
 * For CSS, see the [Katello CSS Conventions] (TODO)
 * For HTML, see the [Katello HTML Conventions] (TODO)

