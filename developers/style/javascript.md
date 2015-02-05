---
layout: documentation
title: "Style Guide: Javascript"
sidebar: sidebars/developer_guide.html
---

# Javascript Code Conventions

This document contains conventions for programming Javascript that should be followed in an effort
to increase readability, performance and re-usability.  As builds are run against the
[JSLint Code Quality Tool](http://www.jslint.com/), an effort should be made to conform to the
guidelines set forth by JSLint.

## General
 * 4 spaces (instead of 2), no tabs
 * camelCase for variables
 * CamelCase for classes, and service names
 * Use empty lines to break up logical code chunks
 * Always use `===` for comparison
 * Place semicolons wherever they are required.  While missing semicolons may not throw an error,
   they can cause unintended behaviors.

## Javascript Libraries

A number of Javascript libraries are used within Katello.  Please refer to each libraries documentation.

  - [jQuery](http://api.jquery.com/)
  - [underscorejs](http://documentcloud.github.com/underscore/)
  - [AngularJS](https://angularjs.org/)

## Syntax Conventions

The following are coding conventions related to Javascript syntax in an effort to enhance
readability and adhere to the semantics of the language itself.

### Conditional Statements

Include spaces around the argument of conditionals:

```javascript
if (condition) {
    // do something
}
```
 
### Variable Declaration

All variable declarations should be placed at the top of a function and a single `var` statement
with comma separated variables should follow.

Correct
```javascript

var add = function (list) {
    var sum = 0,
        length = list.length,
        i;
       
    for (i=0; i < length; i += 1) {
        sum += list[i];
    }

    return sum;
};
```

Incorrect
```javascript

var add = function (list) {
    var sum = 0;
       
    var length = list.length;
    for (var i=0; i < length; i += 1) {
        sum += list[i];
    }

    return sum;
};
```

### Function Declaration vs Function Expression

Use function expressions instead of function declarations because function expressions are more versatile
and less prone to unexpected behavior. 

```javascript
// Function Declaration: don't use this
function add(a,b) {return a + b};
// Function Expression: use this
var add = function (a,b) {return a + b};
```

### Object Iteration

When iterating over an object the `hasOwnProperty()` function should be invoked on each value to
ensure errant properties attached to the object via the prototype chain do not cause unintended
behavior.

Correct
```javascript

var find_product = function (items) {
    var product,
        item;

    for (item in items) {
        if (items.hasOwnProperty(item)) {
            if (items[item] === 'product') {
                product = items[item];
            }
        }
    }

    return product;
};
```

Incorrect
```javascript

var find_product = function (items) {
    var product,
        item;

    for (item in items) {
        if (items[item] === 'product') {
            product = items[item];
        }
    }

    return product;
};
```

### Array Iteration

The `for-in` loop should never be used to iterate over an array.  Instead, opt to use the
traditional:

```javascript

var i,
    length = list.length;

for (i=0; i < length; i+= 1) {
    list[i];
}
```
### Object Attribute Access

Javascript supports both the dot-operator `myobject.foo` and index-style `myobject["foo"]` object
attribute access.  Always use the dot-operator unless dealing with properties that are dynamic,
reserved keywords, or `snake_case` (in order to prevent a JS Hint error).
 
## Performance Conventions

These conventions while not directly related to the syntax of the language serve to improve the
overall performance of any Javascript especially when manipulating the Document Object Model (DOM),
which is the largest performance bottleneck.

### DOM Manipulation

Use [AngularJS directives](https://docs.angularjs.org/guide/directive) to handle DOM manipulation.  
It should be rare to have to manually manipulate the DOM but follow these guidelines if necessary:

 - Access the DOM the minimum number of times possible and save DOM elements to local variables
 - Be wary of looping over DOM elements
 - Know what causes browser reflows and avoid doing so unless absolutely necessary

## Checking Your Code

We use [JSHint](http://www.jshint.com/) (a community driven fork of JSLint) to maintain the quality
of the Javascript code in Katello. For more information about how to run JSHint, see the Linting
section of our Bastion guide at
https://github.com/Katello/katello/blob/master/engines/bastion/README.md#linting.
