---
layout: documentation
title: Release Notes
sidebar: sidebars/documentation.html
---

# Katello 2.3 (Berliner Weisse) Release Notes

{% if site.version && site.version != 'nightly' %}
For the full release notes, see the [Changelog](https://github.com/Katello/katello/blob/KATELLO-{{ site.version }}/CHANGELOG.md).
{% else %}
For the full release notes, see the [Changelog](https://github.com/Katello/katello/blob/master/CHANGELOG.md).
{% endif %}

## Features

### Packaging
 * collect tasks dump with foreman-debug ([#10820](http://projects.theforeman.org/issues/10820), [6c95126](http://github.com/katello/katello/commit/6c95126))

### Installer
 * Peppier katello:reindex ([#10724](http://projects.theforeman.org/issues/10724), [7e246b8](http://github.com/katello/katello/commit/7e246b8))

### Web UI
 * Add scoped search for content view version by version and repository ([#10551](http://projects.theforeman.org/issues/10551), [a7e8ad4](http://github.com/katello/katello/commit/a7e8ad4))

### Capsule
 * provide a way to restart capsule services (cherry picked from commit 3e035bf0e6d7623a825bbdf586f330f5021c8e3f) ([#6781](http://projects.theforeman.org/issues/6781), [e0628b1](http://github.com/katello/katello/commit/e0628b1))
 * require qpid-dispatch-router (cherry picked from commit be194202a7e77703c53c7f619fd89cca768f94b2) ([#8175](http://projects.theforeman.org/issues/8175), [ed710c4](http://github.com/katello/katello/commit/ed710c4))

### Docker
 * Create containers in API using katello repos ([#9518](http://projects.theforeman.org/issues/9518), [#9310](http://projects.theforeman.org/issues/9310), [b17bfc8](http://github.com/katello/katello/commit/b17bfc8))
 * Enable docker repos from the CDN ([#7796](http://projects.theforeman.org/issues/7796), [8c0b497](http://github.com/katello/katello/commit/8c0b497))

### API
 * API localization - Apipie setup moved ([#4478](http://projects.theforeman.org/issues/4478), [ac474b4](http://github.com/katello/katello/commit/ac474b4))

### Foreman Integration
 * use networking snippet during provisioning ([#9132](http://projects.theforeman.org/issues/9132), [217bde0](http://github.com/katello/katello/commit/217bde0))

## Bug Fixes

### Web UI
 * fix enabled product listing ([#10922](http://projects.theforeman.org/issues/10922), [34e1302](http://github.com/katello/katello/commit/34e1302))
 * Loads product content tab on content host, BZ1230782 (cherry picked from commit 4227b7240df02581baa5cef9bfa8a08bc26e951e) ([#10871](http://projects.theforeman.org/issues/10871), [ecf5f26](http://github.com/katello/katello/commit/ecf5f26))
 * Fixes javascript traceback when removing repositories (cherry picked from commit b5d92ffa94d6797d979273bf6a8cacf7b13a1935) ([#10622](http://projects.theforeman.org/issues/10622), [19aa461](http://github.com/katello/katello/commit/19aa461))
 * fix organization delete ([#10655](http://projects.theforeman.org/issues/10655), [eba7cc9](http://github.com/katello/katello/commit/eba7cc9))
 * don't use scroll on unpaged tables BZ 1223968. ([#10617](http://projects.theforeman.org/issues/10617), [38420e5](http://github.com/katello/katello/commit/38420e5))
 * use capsule RPM for registering a content host ([#8728](http://projects.theforeman.org/issues/8728), [#8756](http://projects.theforeman.org/issues/8756), [0172068](http://github.com/katello/katello/commit/0172068))

### Foreman Integration
 * do not create a puppet env for cvs with no modules ([#10459](http://projects.theforeman.org/issues/10459), [#10435](http://projects.theforeman.org/issues/10435), [709ab81](http://github.com/katello/katello/commit/709ab81))
 * send e-mail to all subscribers (cherry picked from commit ce174b43f57e92d9e5b3b18494e7f27d56bffd12) ([#10572](http://projects.theforeman.org/issues/10572), [1c99258](http://github.com/katello/katello/commit/1c99258))
 * fixing host single and bulk delete ([#9577](http://projects.theforeman.org/issues/9577), [90fb5a8](http://github.com/katello/katello/commit/90fb5a8))
 * configure networking in finish template ([#9400](http://projects.theforeman.org/issues/9400), [2df454b](http://github.com/katello/katello/commit/2df454b))

### Capsule
 * fixing capsule sync timeout (cherry picked from commit 3a7238da41c603581f59e3cd3aad620f68225e99) ([#7162](http://projects.theforeman.org/issues/7162), [85be9e3](http://github.com/katello/katello/commit/85be9e3))

### API
 * Adding docker_images method to cvv (cherry picked from commit 5aae5f8ded418d29bbfc994d89723e19561d325a) ([#9755](http://projects.theforeman.org/issues/9755), [11d2894](http://github.com/katello/katello/commit/11d2894))
 * verify errata exist before application ([#9502](http://projects.theforeman.org/issues/9502), [#9503](http://projects.theforeman.org/issues/9503), [6a3a85a](http://github.com/katello/katello/commit/6a3a85a))

### Errata Management
 * fixing race condition on errata index ([#8586](http://projects.theforeman.org/issues/8586), [d379aca](http://github.com/katello/katello/commit/d379aca))

### Subscriptions
 * handle case where content host no longer exists ([#10514](http://projects.theforeman.org/issues/10514), [1874ba1](http://github.com/katello/katello/commit/1874ba1))
 * Backend cleanup script handles uebercert and hypervisors. ([#9915](http://projects.theforeman.org/issues/9915), [3edb3a8](http://github.com/katello/katello/commit/3edb3a8))

### Database
 * Ensure content host exists before updating in migration. (cherry picked from commit 1136484750f1d8b882406cabaf0043fd6692ad39) ([#10426](http://projects.theforeman.org/issues/10426), [3137ab0](http://github.com/katello/katello/commit/3137ab0))

### Upgrades
 * fixing error with import_errata rake task (cherry picked from commit bf6ec73c81ec9329bd0b7f2ca26edc2dc8d8e0ce) ([#9354](http://projects.theforeman.org/issues/9354), [1ef1883](http://github.com/katello/katello/commit/1ef1883))

### API doc
 * remove required flag from DELETE /subscriptions apipie ([#9984](http://projects.theforeman.org/issues/9984), [2cf41d8](http://github.com/katello/katello/commit/2cf41d8))

### Docker
 * Docker Content now hidden for composite cv ([#9610](http://projects.theforeman.org/issues/9610), [68312e2](http://github.com/katello/katello/commit/68312e2))
 * Fix updating of docker upstream name ([#9423](http://projects.theforeman.org/issues/9423), [ab345f5](http://github.com/katello/katello/commit/ab345f5))
 * Docker Content now hidden for composite cv ([#9610](http://projects.theforeman.org/issues/9610), [348c873](http://github.com/katello/katello/commit/348c873))
 * Remove unused erroneous file ([#9539](http://projects.theforeman.org/issues/9539), [1c977c9](http://github.com/katello/katello/commit/1c977c9))

 * fixing db/seeds.rb for katello, BZ 868910 ([#3272](http://projects.theforeman.org/issues/3272), [346f187](http://github.com/katello/katello/commit/346f187))

## Contributors
