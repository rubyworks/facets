# Facets TODO

Small follow-ups that aren't GitHub issues. Newest first.

## Date and Time comparisons (2026-11-08)

Plain Ruby can't compare a Date with a Time: `<=>` returns nil, so `<`, `>`,
`sort` and `max` raise ArgumentError. `facets/date/cmp` converts both to
DateTime and compares those. It passes the Ruby clash rule, since it only
answers where Ruby gives nil, but two things about it may surprise:

- `==` changes too, because it's built on `<=>`.
  `Time.utc(2026, 11, 8) == Date.new(2026, 11, 8)` is true with Facets and
  false without.
- A Date counts as midnight UTC, not local midnight. `Date.new(2026, 11, 8)`
  is earlier than 8 p.m. on November 7 in UTC-5, which is already the 8th in
  UTC.

Ruby itself guesses both ways. It compares a Date with a DateTime as
midnight UTC, but `Date#to_time` gives local midnight. Facets follows the
first, and so does ActiveSupport. A third choice would be to compare by
calendar day (`time.to_date <=> date`), so any time on the 8th equals the
8th. Decide later, and at least document whichever one Facets keeps.

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

## An old warning under `ruby -w` (2026-11-02)

`ruby -w -e "require 'facets'"` prints a warning, in 4.0.0 as well as 4.0.1:

- `lib/core/facets/string/unfold.rb:13: warning: assigned but unused variable
  - blank`. `#unfold` sets `blank` and never reads it. Remove it, or use it
  for the method's FIXME about adding one blank line too many, which is why
  the result is `rstrip`ped.

(The `Kernel#extend` "method redefined" warning is gone since 2026-11-04:
Facets removes Ruby's method before defining its own.)

Once it's gone, consider a test that `require 'facets'` is silent under
`-w`, so new warnings get caught.
