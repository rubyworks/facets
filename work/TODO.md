# Facets TODO

Small follow-ups that aren't GitHub issues. Newest first.

## rubytest runs 0 tests for several files with `-I` (2026-11-02)

With any `-I` option, giving `rubytest` more than one test file silently runs
nothing:

```sh
bundle exec rubytest -Ilib/core test/standard/test_interval.rb test/standard/test_shellwords.rb
# Executed 0 tests with .
```

The same two files without `-I` run 13 tests, and one file with `-I` works.
The position of `-I` doesn't matter. Facets' Rake tasks aren't affected,
because each passes a single directory, and `TESTS="a.rb b.rb" rake test`
passes no `-I`. But someone running a few files by hand gets a false "all
passed".

This is a rubytest bug (rubytest 0.9.0), so fix it in `../rubytest`,
probably in how the command line splits options from file arguments.

## Two old warnings under `ruby -w` (2026-11-02)

`ruby -w -e "require 'facets'"` prints two warnings, in 4.0.0 as well as
4.0.1:

- `lib/core/facets/kernel/extend.rb:22: warning: method redefined; discarding
  old extend`. Facets deliberately replaces `Kernel#extend` with
  `define_method` so it can take a block. Either remove the original first
  (it is already kept in `extend_method`), or move the override into a
  module that is prepended to `Kernel`.
- `lib/core/facets/string/unfold.rb:13: warning: assigned but unused variable
  - blank`. `#unfold` sets `blank` and never reads it. Remove it, or use it
  for the method's FIXME about adding one blank line too many, which is why
  the result is `rstrip`ped.

Once both are gone, consider a test that `require 'facets'` is silent
under `-w`, so new warnings get caught.
