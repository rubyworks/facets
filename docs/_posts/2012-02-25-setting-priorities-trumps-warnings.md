---
title: Setting Priorities Trumps Warnings
date: 2012-02-25
---

> **Update, November 2026:** Ruby never adopted exception priorities. It went another way, sorting warnings into named categories rather than levels. Ruby 2.4 added the `Warning` module, whose `Warning.warn` can be overridden to decide what happens to each warning. Ruby 2.7 added `Warning[]` and `Warning[]=`, and command-line options such as `-W:no-deprecated`, to switch the `:deprecated` and `:experimental` categories on and off; since Ruby 2.7.2, deprecation warnings are off by default. Ruby 3.0 let `warn` take a `category:` keyword, though it accepts only Ruby's own categories, and Ruby 3.3 and 3.4 added the `:performance` and `:strict_unused_block` categories. `$VERBOSE` still has just three settings, `nil`, `false` and `true`, and `warn` is still separate from `raise`.

Today I had to consider how best to handle omission exceptions in the context of test frameworks, and their use case to mark *pending tests*. In the course of doing so, I realized there are at least two reasonable levels of omission, those that are "ASAP" and those that are "NSM" (Not So Much). Whereas other frameworks used their own specially defined classes for these, e.g. `Pending` and `Omission`, my approach is to re-utilize Ruby's own `NotImplementedError`. But then I had to consider how to differentiate between these priorities.

And that's when the more general notion occurred to me of **Exception Priorities**.

Consider that instead of raising a warning:

```ruby
warn "Don't do it, mate!"
```

We could use the Exception system, setting a low "warning" level priority.

```ruby
raise "Don't do it, mate!", -1
```

All things being nominal, Ruby would see the priority of this exception is below 0, output the message to `$stderr` if `$VERBOSE=true` and then continue on. Hence it is a warning!

With this, `#warn` could become a simple alias for `#raise` with a default negative priority.

Now, if that was all there was to it, then there would be little reason to adopt the idea. But there are some really nice advantages to this approach.

With regards to warning messages, we could use the `$VERBOSE` setting to refine the level of warning we want to be notified about. 

```ruby
$VERBOSE = -1
raise "More Serious Warning!", -1
raise "Less Serious Warning!", -2
```

In this case we would never see the `-2` level warning b/c we've indicated we don't want to see those by setting $VERBOSE to a higher specific level.

Interestingly enough, we can do the same for actually raising errors! Let's call the setting `$PRIORITY` for the sake of discussion.

```ruby
$PRIORITY = -1
raise "More Serious Warning!", -1
raise "Less Serious Warning!", -2
```

Whereas before, the "More Serious Warning" would just have printed a warning message to `$stderr`, in this case the Exception will actually be raised, b/c we have lowered the threshold at which exceptions are to be raised.

This refinement to Ruby's Exception system, effectively subsuming the warning system within it, makes for a much more powerful, flexible and thus useful system. Take my original use case, I can set the priority of NotImplementedError to `1` for ASAPs and `0` for NSMs, and I can go further allowing testers to set high priorities to be selectable from the command line.

Want another use case? How about a `DeprecatedError` that has a default priority of `-1`.

I am certain others will think of other use cases as well. This is one of those pliable features that tend to have far wider applicability than the originating use case.

P.S. I've always thought it would make more sense if `$VERBOSE` were called `$WARN`.
