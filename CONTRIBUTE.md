# CONTRIBUTING TO FACETS

* Facets methods must have no external dependencies. (The only possible
  exception to this is if the functor gets spun-off as a separate gem along
  with related methods, but for now that's not happening.)

* Each method must be in it's own file of the same name. If the method ends
  with `=` or `?` just leave it off the file name. On rare occasion two or more
  methods can be very tightly related. In these cases he methods can all go in
  a single file under the name of the method considered most significant. 
  Files for the other methods should usually still be create that simply
  require the main file.

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
  (or tightly related set of methods) is in it's own pull request. This can be
  done either through separate commits or separate branches. Let me emphasizes
  this point because it makes it *much more likely* that your pull request
  will be merged. If you submit a bunch of methods in a single request, it is
  more likely that the request will not be merged even if methods you submitted
  are accepted!!!

* Don't be discouraged when you get feedback about a method that isn't
  all sunshine and roses. Facets has been around long enough now that 
  it needs to maintain a reasonable level of quality, and that means
  serious discernment about what goes into the library. That includes 
  discussion about the best name for a method --even if the functionality
  has been accepted the name may not.

