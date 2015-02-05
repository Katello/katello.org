---
layout: documentation
title: "Bastion: Add Entity"
sidebar: sidebars/developer_guide.html
---

# Basics of Adding a New Entity

When adding functionality that introduces a new entity that maps to an external resource, there are a few common steps that a developer will need to take.

First, create a folder in `app/assets/bastion` that is the plural version of the entity name (e.g. content-hosts). Follow by creating a file to hold the module definition and the resource.

```bash
mkdir app/assets/bastion/content-hosts
touch app/assets/bastion/content-hosts/content-hosts.module.js
touch app/assets/bastion/content-hosts/content-host.factory.js
```

## Module

The module defines a namespace that all functionality dedicated to this entity will be attached to. This makes testing and composing components together easier. For example, the content-hosts module definition might look like:

```javascript
/**
* @ngdoc module
* @name  Bastion.content-hosts
*
* @description
*   Module for content-hosts related functionality.
*/
angular.module('Bastion.content-hosts', [
    'ngResource',
    'alchemy',
    'alch-templates',
    'ui.router',
    'Bastion.widgets'
]);
```

The module definition defines the 'Bastion.content-hosts' namespace and tells Angular to make available the libraries `ngResource`, `alchemy`, `alch-templates`, `ui.router` and `Bastion.widgets`. These libraries are other similarly defined Angular modules.

## Routing

### Client Side

In order to display a Bastion page you must add a route for the page.  A route to view all content-hosts may look like this:

```javascript
$stateProvider.state('content-hosts.index', {
    url: '/content_hosts',
    views: {
        'table': {
	    controller: 'ContentHostTableController',
	    templateUrl: 'content-hosts/views/content-hosts-table-full.html'
        }
    }
});
```

The views object contains a list of addressable views that allow the association of Angular controllers and templates with a URL.
See the UI router [documentation](http://angular-ui.github.io/ui-router/site/#/api/ui.router) for more information.

### Server Side

On the server side you need to add the entity name to the list of known pages in [engine.rb](https://github.com/Katello/katello/blob/master/engines/bastion_katello/lib/bastion_katello/engine.rb).

If the new entity is to be addressable at /new_entity, for example, then you should add new_entity to the `@pages` array.

Note that you will need to restart rails after making this change.

## Resource

A resource serves as a representation of an API endpoint for an entity and provides functions to make RESTful calls. Files and factories that represent external resources should be represented by their singular model name, for example the resource for content-hosts is in `content-host.factory.js` and represented by:

```javascript
angular.module('Bastion.content-hosts').factory('content-host',
    ['$resource', function($resource) {
	return $resource('/api/v2/content-hosts/:id/:action',
	    {id: '@uuid'},
	    {
		 update: {method: 'PUT'},
		 query: {method: 'GET', isArray: false},
		 releaseVersions: {method: 'GET', params: {action: 'releases'}
	    }
	});

    }]
);
```

Here we have created an angular factory named `content-host` and attached it to the `Bastion.content-hosts` namespace. You can read more about the $resource service here - http://code.angularjs.org/1.0.7/docs/api/ngResource.$resource

## Asset Pipeline

In order to get your newly created assets available to the web pages, we need to add them to the master manifest file. For our content-host example, open app/assets/bastion/bastion.js, add a reference to the module file and a line to load all files within our directory. We must include the module definition first so that all factories, controllers etc. that attach to the namespace have that namespace available.

Open the file:

```bash
vim app/assets/bastion/bastion.js
```

Now add the following lines (with empty lines above and below for organizational purposes):

```javascript
//= require "bastion/content-hosts/content-hosts.module"
//= require_tree "./content-hosts"
```
