# CONTRIBUTING TO FACETS

* Facets methods must have no external dependencies. (The only possible
  exception to this is fi we decide to spin functor methods off to a
  separate functor gem, but for now that is not happening.)

* Methods must be tested either via a Lemon unit test or a QED demo,
  preferrably both. The Lemon unit tests are for testing a method in
  detail whereas the QED demos are for demonstrating usage.

* Facets is divided into two parts, *core* and *standard* libraries.
  All of the core library is loaded by default when using `require 'facets'`
  (actually, almost all). The standard library (sometimes called the *more*
  library) must be required per-script.

* Some core methods are included on a *trial* basis, and these are not 
  necessary loaded automatically with `require 'facets'`.

