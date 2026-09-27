# CONTRIBUTING TO FACETS

## General Rules

* Facets methods must have no external dependencies. (The only possible
  exception to this is if the functor gets spun-off as a separate gem along
  with related methods, but for now that hasn't happened.)

* Each method must be in it's own file of the same name. If the method ends
  with `=` or `?` just leave it off the file name.

* On rare occasion two or more methods can be very tightly related. In these
  cases the methods can all go in a single file under the name of the method
  considered most significant. Usually files for the other methods should
  still be created that simply require the main file.

* Methods must be tested both via a Lemon unit test and as a QED demo.
  The Lemon unit tests are for testing a method in detail whereas the QED
  demos are for demonstrating usage.

* Facets groups libraries into `core`, `standard`, and `rails` areas.
  Almost all core extensions can be loaded at once with `require 'facets'`.
  Standard and rails extensions should be required by file.

* Some core methods are included on a *trial* basis, and these are not
  necessary loaded automatically with `require 'facets'`. These should be
  documented as such in the method comments.

* Standard libraries that are not extensions of existing standard libraries
  do not have to be divvied up into individual method files. But note that
  full classes and/or modules are less likely to make it into Facets, as
  these sorts of additions to Facets are only for very basic sorts of things.
  Otherwise they'd deserve their own gem.

* When submitting new methods for consideration, it is best if each method
  (or *tightly related* set of methods) is in it's own pull request. If you
  have only one method to submit then a simple  commit will do the trick. If
  you have more than one it best to use separate branches. Let me emphasizes
  this point because it makes it *much more likely* that your pull request
  will be merged. If you submit a bunch of methods in a single pull request,
  it is very likely that it will not be merged even if methods you submitted
  are accepted!!!

* Don't be discouraged when you get feedback about a method that isn't
  all sunshine and roses. Facets has been around long enough now that
  it needs to maintain a certain degree of quality control, and that means
  serious discernment about what goes into the library. That includes
  having in depth discussions the merits of methods, even about the best
  name for a method --even if the functionality has been accepted the name
  may not.


## Versioning

Facets tries to follow a semantic versioning system, but with a slightly
differt scheme than most projects. For Facets the version number represents:

    gestault.major.minor

Techinically there can be a fouth `build` number, but we never use it for
releases.


## Commit Tags

When making a commit, it is helpful to add a *commit tag* to the end of the
first line of commit message. Commit tags are single words wrapped in colons.

* If the commit is only a documentation change, then and `:doc:`.
* If it is only a change to tests then add `:test:`.
* If the change only effects project build or config files then add `:admin:`.
* If the change fixes a bug that was reported via the issue system be sure
  to reference the issue number in the message using `#` and add a `:bug:` tag.
* For actual code changes, if the change is *very minor* and not something
  anyone would notice, you can use `:tweak:`, if you want. 
* If the change would require a minor version change than use `:minor:`.
* But if a change is a significant change to the API, and thus will require
  a major version change, then end the message with `:major:`.

These are all rules of thumb, and no one expects them to be applied perfectly.


## Documentation

Facets started when the only choice for API documentation was RDoc. So originally
that's how methods were documented. Since then both YARD and Tomdoc have come
along. And some of these documentation styles have crept into a number of
methods. So right now, things are a bit messy. But going forward it looks like we
are going to settle on Tomdoc as the official documentation style (but using
the tomparse gem's extensions). Using Tomdoc will give us reasonable
interoperability with both RDoc and YARD, both of which now have support for
Tomdoc (albeit support is not 100% the same, but hopefully it's close enough).

Officially we publish documentation via rubydoc.info, which is the YARD server,
and via the Facets website in Shomen JSON format.

When writing documentation for a method it is best to give a simple summary
explanation, followed by some basic examples. Follow that up with deeper
explanation if needed, including *when* and *why* the method could be useful.


## Testing

The test suite uses four tools:

* **RubyTest** provides the test runner interface; `rubytest-cli` supplies the
  `ruby-test` command used by the Rake tasks.
* **Lemon** defines the `test_case`, `method`, and `test` structure of the unit
  tests.
* **AE** provides assertions such as `.assert` and `expect` inside those tests.
  It is installed as a Lemon dependency.
* **QED** runs the executable examples in `demo/`. They show how a method is
  intended to be used as well as checking its behavior.

Install the development dependencies and run the same two suites as CI:

```sh
bundle install
bundle exec rake test
bundle exec rake qed
```

For a focused unit test, set `TESTS` to a test file, for example:

```sh
TESTS=test/core/array/test_average.rb bundle exec rake test
```

The Rakefile also provides `test:core`, `test:standard`, `test:rails` and the
corresponding `qed:*` tasks for each library area.

* A core method in `lib/core/facets/{class}/{method}.rb` normally has a Lemon
  test in `test/core/{class}/test_{method}.rb` and a QED demo in
  `demo/core/{class}/{method}.md`. Standard and rails libraries use
  their respective `test/` and `demo/` directories.
* A file that only requires another file does not need its own unit test. A file
  that also defines an alias can test the alias without repeating every test
  for the underlying method.
* Demos should show the behavior of each method. An alias can have a short demo
  that points readers to the main method's demo.
