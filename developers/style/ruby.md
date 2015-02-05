---
layout: documentation
title: "Style Guide: Ruby"
sidebar: sidebars/developer_guide.html
---

# Ruby Code Conventions

 * When indenting always use two spaces. Never use a tab character.
 * Always run ''ruby -w'' to see all ruby parses warnings and recommendations.
 * Naming conventions:
   * classes and modules: `CamelCase`
   * methods and variables: `snake_case`
   * constants: `UPPER_SNAKE_CASE`
 * Use `{ }` for single-line blocks, `do end` for multi-lines blocks e.g.:

```ruby
names.each { |name| puts name.upcase }

names.each do |name|
  puts "Hello #{name}"
  puts "How are you?"
end 
```

 * In regard to using parentheses with methods:
   * We recommend against using parentheses for methods and method definitions
     without arguments.
   * We highly recommend using parentheses for all other methods and method
     definitions. The only exception is when it's used as DSL.


```ruby
def name                  # good
def name()                # bad
def open(file, mode)      # good
def open file, mode       # bad
name                      # good
name()                    # bad
open("file.txt", "w")     # good
open "file.txt", "w"      # bad
name.is_a? String         # acceptable, we consider that a DSL for type checking
render :index             # acceptable, Rails DSL
```

  * Avoid class variables (@@variable) wherever possible. Instead, try to use a
    instance variable (@variable) or at least a thread-safe variable
    (Thread.current[:variable]).

### More info

We also recommend most of the conventions in the community driven Ruby and Rails style guides:

* https://github.com/bbatsov/ruby-style-guide
* https://github.com/bbatsov/rails-style-guide

## Checking your code

To enforce the styles from the style guide and also to check for warnings/error, we use rubocop. The
gem is available as part of the development group in katello.gemspec. To run rubocop, simply execute
this from you foreman directory:

```
rake katello:rubocop
```

Also, rubocop [integrates with some IDES](https://github.com/bbatsov/rubocop#editor-integration).
