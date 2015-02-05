katello.org
===========

[![Build Status](https://travis-ci.org/Katello/katello.org.svg)](https://travis-ci.org/Katello/katello.org)

Katello Documentation and Website

## Running Locally

The documentation can be run locally for viewing or editing. To do so:

1. Clone this repository
1. Bundle install
1. Run `jekyll serve --watch --host localhost`
1. From a web browser, access `http://localhost:4000`

## Testing

Pull requests to this repository are automaticaly tested by Travis, which runs
the deploy script as noted below, and then running html-proofer over the result.

You can test individual branches locally by running 'rake test:local'.

## Deploying katello.org

The katello.org website is deployed using a script that builds the site locally and incorporates all the various version branches of our documentation. The strategy is to build the docs/ folder of each version within the context of the current 'nightly documentation in order to keep styling consistent. The script and branch that handles this can be found under 'deploy'. In order to test or modify the deployment:

1. Clone this repository
1. git checkout deploy
1. run ./deploy.rb
1. cd public/
1. Serve static documents (e.g. python -m SimpleHTTPServer 7777)
