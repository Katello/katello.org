---
layout: documentation
title: "Bastion: Dependencies"
sidebar: sidebars/developer_guide.html
---

# Dependencies

Web asset dependencies are stored in `bower.json`. This file denotes what library files are being used and their versions.

## Installing a New Dependency

In order to add a new web asset dependency, a new entry into the `bower.json` file must be made along with noting what file(s) to extract from the new package to be placed into source control. For example, to add the `angular-blocks` library, open `bower.json` and add an entry under the `dependencies` section:

```javascript
"angular-blocks": "~>0.1.8"
```

Since Bower is based off the use of a git repository to define the package contents, installing `angular-blocks` will pull down more files than we want. In order to limit the files places into source control, add an entry to the `exportsOverride` section like so:

```javascript
"angular-blocks": {
  "javascripts/bastion": "src/angular-blocks.js"
}
```

If needing to extract multiple asset types, one can do:

```javascript
"alchemy": {
  "javascripts/bastion": "alchemy.js",
  "stylesheets/bastion": "*.scss"
}
```

A set of files can be included by using an array instead of a string to list the files. After defining the new dependency and the associated file(s), run the following to install the new library:

    grunt bower:update

## Updating a Dependency

To update a dependency, the version must be bumped in the `bower.json` file, installed and committed to source control. To bump the version, open `bower.json`, locate the proper entry and change the version number. Now, install the new version:

```bash
grunt bower:update
```

Lastly, double check the new files with something like `git status`, add them and commit them with a message indicating that a new dependency version is being committed. We prefer that when committing a new depenendency, a single commit is generated with just the changes from the update.

## Example Dependency Errors

[See *Fixing Dependency Errors*](#fixing-dependency-errors) for more commands to help fix errors such as these:

**Error 1: local Npm module not installed**

`Local Npm module "grunt-angular-gettext" not found. Is it installed?`

Running `npm install` and `grunt bower:dev` again should fix the issue.

**Error 2: the unmet dependency**

*Traceback abbreviated to highlight error*

```
npm WARN unmet dependency /usr/lib/node_modules/block-stream requires inherits@'~2.0.0' but will load
npm WARN unmet dependency undefined
```

Running `sudo npm update -g phantomjs bower grunt-cli` should fix the issue.

### Fixing Dependency Errors

[See *Example Dependency Errors*](#example-dependency-errors) to see common errors and their fixes.

Over time libraries, packages, and/or dependencies are often updated or added so you may have to rerun one or more
of the following commands to fix them:

**Note**: You only need to run `grunt bower update` when updating or pulling in changes to `bower.json` where the
version of a component has been bumped.

[See also *Installing a New Dependency*](#installing-a-new-dependency) as well as the related section
[*Updating a New Dependency*](#updating-a-dependency)

- `sudo npm update -g phantomjs bower grunt-cli`
- `npm install`
- `grunt bower:dev`
