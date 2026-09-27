# Ruby Facets <img src="docs/assets/images/cherries.svg" alt="cherries" width="34" height="34">

[![Gem Version](https://badge.fury.io/rb/facets.svg)](https://rubygems.org/gems/facets)
[![CI](https://github.com/rubyworks/facets/actions/workflows/ci.yml/badge.svg)](https://github.com/rubyworks/facets/actions/workflows/ci.yml)

**More of Ruby, one method at a time.** Facets is a collection of extensions to Ruby's core classes and standard library, plus a few small, reusable classes and modules. Most methods live in their own files, so you can load one extension, a class's extensions, or the core collection.

Facets took its name in 2004, growing out of a small methods library started in 2002, and is still maintained. The current release is **3.2.2**, which requires **Ruby 3.1 or newer**. See the [release history](HISTORY.md) for changes and migration notes from earlier versions. The `main` branch also contains changes awaiting the next release.

## Install

```sh
gem install facets
```

With Bundler, add this to your Gemfile:

```ruby
gem 'facets', require: false
```

`require: false` lets you choose which extensions to load. Omit it if you want Bundler to load the core collection automatically.

## Choose how much to load

### One method

```ruby
require 'facets/array/to_ranges'

[1, 2, 3, 6, 7].to_ranges
#=> [1..3, 6..7]
```

### One class's core extensions

```ruby
require 'facets/string'

'Ruby Facets'.snakecase
#=> "ruby_facets"
```

### The core collection

```ruby
require 'facets'

[1, 2, 3].average
#=> 2.0
```

`require 'facets'` loads the broadly useful **core** extensions: roughly 860 methods from 448 files, adding about 35 ms of load time and 2 MB of memory (Ruby 3.3, Linux). Some specialized core extensions are opt-in; require their method file directly. To load Facets extensions to a Ruby standard library, require that library through Facets:

```ruby
require 'facets/ostruct'
```

This loads `ostruct` and Facets' OpenStruct extensions. On Ruby 3.5+, declare the `ostruct` gem separately because it is no longer a default gem.

## Documentation

- [Getting started and loading guide](https://rubyworks.github.io/facets/learn.html)
- [Generated API documentation on RubyDoc.info](https://www.rubydoc.info/gems/facets) (check the displayed version)
- [Release history](HISTORY.md)

In the published 3.2.2 gem, the split between `lib/core` and `lib/standard` is visible in API source paths. This helps you tell whether a method is loaded by `require 'facets'` or needs an explicit require. The development branch also has a new `lib/rails` area for Rails-compatible helpers; see the **Unreleased** section of the release history for details.

## Contribute

Issues and pull requests are welcome. Start with [CONTRIBUTING.md](CONTRIBUTING.md) for the library's method organization, demos, and test conventions. The test suite runs with:

```sh
bundle install
bundle exec rake test
```

[Source](https://github.com/rubyworks/facets) · [Issues](https://github.com/rubyworks/facets/issues) · [Website](https://rubyworks.github.io/facets/)

## License and credits

Facets is distributed under the [BSD 2-Clause License](LICENSE.txt). Thomas Sawyer started the project, and many Rubyists have contributed code, ideas, tests, and documentation. Individual files record additional credits where applicable.

*All your base are belong to Ruby.*
