---
layout: documentation
title: "Bastion: Adding a Custom Module"
sidebar: sidebars/developer_guide.html
---

# Adding a Custom Module

If creating a plugin that you would like to hook into and take advantage of the Bastion setup, your custom module can be 
added to the list of modules that are imported at application bootstrap. Adding a custom module requires two steps: 
ensuring your assets are included on the page and declaring the inclusion of your module. The former can be achieved through
various methods and depends on your setup. To declare the inclusion of your module, ensure the following is defined somewhere
within your JavaScript (we recommend adding it to the top of your mymodulename.module.js file or in a separate 
mymodulename-bootstrap.js file):

```javascript
BASTION_MODULES.push('myModuleName');
```
