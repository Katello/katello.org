---
layout: documentation
title: Testing
sidebar: sidebars/developer_guide.html
---

# Speeding up tests

Running the tests in Katello can take quite a while, especially the ruby ones.
This guide will help in trying to speed up your testing workflow by giving you
some tips.

## When to run tests

An important part of testing is knowing which tests to run and when. This can
save you a lot of time. 

Very rarely should you run the entire test suite locally. Instead, just let
Jenkins run it for you after you open a PR. Locally, run new tests you write
along with any tests you think might be affected.

To run an individual file:

```
rake test:katello TEST=../katello/test/models/content_view_test.rb
```

To run an individual test:

```
# testunit style
rake test:katello TEST=../katello/test/models/content_view_test.rb TESTOPTS="-ntest_create"

# spec style
rake test:katello TEST=../katello/test/actions/katello/environment_test.rb TESTOPTS="-n/plans/"
```

## Tools to speed up testing

One of the reasons the Rails tests take such a long time is that the Rails
environment must be loaded. There are some tools to help get around this.

### Rail preloaders

Rails preloaders work by loading up your Rails environment in the background and then waiting for
whenever you have to run tests. They can also speed up other boot times like running Rails console
or Rails server.

* [spring](https://github.com/rails/spring) - a basic one from the Rails team
* [zeus](https://github.com/burke/zeus) - more features than spring (setup described below)

### zeus setup

First, simply install the gem.
```
gem install zeus
```

In order to be able to run katello tests, a pair of configuration files should be placed in the foreman directory.
**custom_plan.rb**

```ruby
require 'zeus/rails'

class CustomPlan < Zeus::Rails
  def test_environment
    require 'minitest/unit'
    require 'minitest-spec-rails'
    require 'minitest-spec-rails/init/active_support'
    require 'minitest-spec-rails/init/mini_shoulda'
    MiniTest::Unit.class_variable_set("@@installed_at_exit", true)
    $LOAD_PATH.unshift '../katello/test'
    $LOAD_PATH.unshift '../katello/spec'
    super
  end
end

Zeus.plan = CustomPlan.new
```

**zeus.json**

```json
{
  "command": "ruby -rubygems -r./custom_plan -eZeus.go",

  "plan": {
    "boot": {
      "default_bundle": {
        "development_environment": {
          "prerake": {"rake": []},
          "runner": ["r"],
          "console": ["c"],
          "server": ["s"],
          "dbconsole": []
        },
        "test_environment": {
          "test_helper": {"test": ["testrb"]}
        }
      }
    }
  }
}
```

Now start zeus from the foreman directory. The output will be colored to indicate the status of each aspect of the server. Wait for the "zeus test (alias: testrb)" to be green.

```
$ zeus start
Starting Zeus server v0.15.4
[ready] [crashed] [running] [connecting] [waiting]
boot
└── default_bundle
    ├── development_environment
    │   └── prerake
    └── test_environment
        └── test_helper

Available Commands: [waiting] [crashed] [ready]
zeus rake
zeus runner (alias: r)
zeus console (alias: c)
zeus server (alias: s)
zeus generate (alias: g)
zeus destroy (alias: d)
zeus dbconsole
zeus test (alias: testrb)
```

Note: If running in an *sshfs* mounted foreman directory, zeus may fail to start with the message *"Unable to accept socket connection."* and *"It looks like Zeus is already running. If not, remove .zeus.sock and try again."* If this is the case, try setting the location of the socket zeus uses and starting again.

```bash
export ZEUSSOCK=/tmp/zeus.sock
```

Once the *zeus test* is ready (colored green), try running a test from the foreman directory.

```
$ zeus test ../katello/test/controllers/api/v2/systems_bulk_actions_controller_test.rb
# Running tests:

...................

Finished tests in 12.184788s, 1.5593 tests/s, 5.9090 assertions/s.

19 tests, 72 assertions, 0 failures, 0 errors, 0 skips
```

### ktest

Another simple way to speed up tests is by skipping some of the loading and pre-test tasks by
running Ruby directly. This script will speed up your load time by as much as 30-60 seconds. Simply
copy the code below into a script file in your PATH (e.g. ~/.bin/ktest).

```sh
#!/usr/bin/env sh

KATELLO_PATH=/path/to/your/katello/project

if [[ -n $1 ]]
then
  RAKE_PATH=`bundle show rake`
  ruby -I"lib:test:${KATELLO_PATH}/test:${KATELLO_PATH}/spec" -I"${RAKE_PATH}/lib" $@
else
  bundle exec rake test:katello
fi
```

Then you can run a test file like so:

```
ktest ../katello/test/models/content_view_test.rb
```

Or run an individual test:

```
ktest ../katello/test/models/content_view_test.rb -ntest_create
```

You can even record your glue tests:

```
mode=all ktest ../katello/test/models/glue/repository_test.rb
```

One thing to note is that while the normal rake test command will migrate the database, ktest will
not (in the interest of saving time). To do this, simply run this in your foreman directory:

```
RAILS_ENV=test rake db:drop && RAILS_ENV=test rake db:create && RAILS_ENV=test rake db:test:prepare && RAILS_ENV=test rake db:migrate
```

Or if you're a CLI ninja, you can alias it:

```
alias testdb='RAILS_ENV=test rake db:drop && RAILS_ENV=test rake db:create && RAILS_ENV=test rake db:test:prepare && RAILS_ENV=test rake db:migrate'
```
