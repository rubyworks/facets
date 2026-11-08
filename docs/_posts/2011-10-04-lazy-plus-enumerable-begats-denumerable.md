---
title: Lazy Plus Enumerable Begats Denumerable
date: 2011-10-04
---

> **Update, November 2026:** Ruby 2.0 added `Enumerable#lazy`, which does what `defer` does here, and Facets has deprecated `defer` in its favor. `Denumerable` and `Denumerator` are still in Facets.

All Rubyists know and love Enumerable. It's really the showcase of Ruby's mixin system. Some Rubyists also know and appreciate [lazy.rb](https://web.archive.org/web/20110912073235/http://moonbase.rydia.net:80/software/lazy.rb/) MenTaLguY's excellent lazy evaluation library. But did you know there is library that essentially cross-breeds the ideas of both? It's called [Denumerable](https://github.com/rubyworks/facets/blob/main/lib/core/facets/denumerable.rb) and is included in Ruby Facets (`require 'facets/denumerable'`).

According to Webster's The term `denumerable` is just a synonym for `enumerable`. In Ruby parlance, it takes a more useful distinction of "deferred enumerable". In other words Denumerable defers actual calculations of a chain of enumerable method calls until the results are actually needed. That's where the "laziness" comes in. By deferring calculation Ruby is able to optimize the algorithm, in many cases greatly improving performance. It's even possible to enumerate infinite ranges if the end result itself is finite.

To make it even more convenient there is [Enumerable#defer](https://github.com/rubyworks/facets/blob/main/lib/core/facets/enumerable/defer.rb) (`require 'facets/enumerable/defer'`) which delegates an Enumerable object through a Denumerator, just like Ruby's core Enumerator class.

So, enough talk, right? How about an example.

```ruby
a = (1..1_000_000_000).defer.select{ |i| i % 2 == 0 }.
                             map{ |i| i + 100 }.
                             take(10).to_a
=> [102, 104, 106, 108, 110, 112, 114, 116, 118, 120]
```

The performance gains of Denumerable cannot be understated. The above example takes 1/10000th of a second to run on my system. I wanted to provide the time it takes to run without `defer`, but after an hour of waiting and listening to it eat my hard drive for breakfast, I gave up.

