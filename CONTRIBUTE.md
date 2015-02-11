# CONTRIBUTING TO FACETS

* Facets methods must have no external dependencies. (The only possible
  exception to this is if the functor gets spun-off as a separate gem along
  with related methods, but for now that's not happening.)

* Each method must be in it's own file of the same name. If the method ends
  with `=` or `?` just leave it off the file name.

* On rare occasion two or more methods can be very tightly related. In these
  cases the methods can all go in a single file under the name of the method
  considered most significant. Usually files for the other methods should
  still be created that simply require the main file.

* Methods must be tested either via a Lemon unit test or a QED demo,
  preferably both. The Lemon unit tests are for testing a method in
  detail whereas the QED demos are for demonstrating usage.

* Facets is divided into two parts, *core* and *standard* libraries.
  All of the core library is loaded by default when using `require 'facets'`
  (actually, almost all). The standard library (sometimes called the *more*
  library) must be required per-script.

* Some core methods are included on a *trial* basis, and these are not
  necessary loaded automatically with `require 'facets'`.

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
  may not!

* When making a commit, if the commit is only a documentation change, then
  and `[doc]` to the end of the first line of commit message. If it is only
  a change to tests then add `[test]`. If the change only effects build files
  then add `[admin]`. For actual code changes, if the change is not something
  anyone would notice, use `[tweak]` or `[minor]` (minor being slightly more
  important than tweak). For typical code changes no comment tag is necessary.
  If the change fixes a bug that was reported via the issue system be sure to
  reference the issue id in the message using `#` and add `[bug]`. If a change
  is a significant change to the API, then end the message with `[major]`.
  These are all rules of thumb, and no expects them to be applied perfectly.

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

