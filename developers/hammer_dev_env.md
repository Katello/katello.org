---
layout: documentation
title: Hammer Dev Environment
sidebar: sidebars/developer_guide.html
---

# Katello Hammer CLI Development Setup

This will allow you to run hammer-cli-foreman and hammer-cli-katello from git for development.

## Prerequisites

The development environment requires the following tools to be present before setup:

- git
- ruby and/or RVM
- a running [katello server](https://github.com/Katello/katello-installer#development-usage) (local or otherwise)

## Clone the git repositories

```
git clone https://github.com/theforeman/hammer-cli-foreman.git
git clone https://github.com/Katello/hammer-cli-katello.git
```

## Setup of RVM environment

**note: you can skip this step if you aren't using RVM**

```bash
pushd hammer-cli-Katello
echo "1.9.3" > .ruby-version
echo "hammer" > .ruby-gemset
cd . # to have RVM load the correct ruby version and gemset
```

## Point to local gems and bundle

Tell bundler to look for hammer-cli-foreman locally:

```bash
echo "gem 'hammer_cli_foreman', :path => '../hammer-cli-foreman'" > Gemfile.local
```
then run `bundle install`.

## Hammer configuration

Now it's time to create config files for Hammer and its loaded plugins.

```bash
# create the directory structure
mkdir -p ~/.hammer/cli.modules.d

# base hammer config
cat <<-EOF > ~/.hammer/cli_config.yml
:ui:
  :interactive: true
  :per_page: 20
  :history_file: '~/.hammer/history'

:watch_plain: false

:log_dir: '~/.hammer/log'
:log_level: 'error'
:log_api_calls: false
EOF

# hammer-cli-foreman
cat <<-EOF > ~/.hammer/cli.modules.d/foreman.yml
:foreman:
  :enable_module: true
  :host: http://you_hostname_here
  :username: admin
  :password: changeme
EOF

# hammer-cli-katello
cat <<-EOF > ~/.hammer/cli.modules.d/katello.yml
:katello:
  :enable_module: true
EOF
```

## Try it out!

```
$ hammer --help
Usage:
    hammer [OPTIONS] SUBCOMMAND [ARG] ...

Parameters:
    SUBCOMMAND                    subcommand
    [ARG] ...                     subcommand arguments

Subcommands:
    ...
    ...

Options:
    --autocomplete LINE           Get list of possible endings
    --csv                         Output as CSV (same as --output=csv)
    --csv-separator SEPARATOR     Character to separate the values
    --interactive INTERACTIVE     Explicitly turn interactive mode on/off
                                  One of true/false, yes/no, 1/0.
    --output ADAPTER              Set output format. One of [base, table, silent, csv]
    --show-ids                    Show ids of associated resources
    --version                     show version
    -c, --config CFG_FILE         path to custom config file
    -h, --help                    print help
    -p, --password PASSWORD       password to access the remote system
    -u, --username USERNAME       username to access the remote system
    -v, --verbose                 be verbose
```
