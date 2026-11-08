---
title: This Old Hash
date: 2008-10-06
---

> **Update, November 2026:** Ruby never adopted a hash like the one
> proposed here, but converting keys got easier. Ruby 2.5 added
> `Hash#transform_keys` and `Hash#transform_keys!`, so
> `h.transform_keys(&:to_sym)` now does in core Ruby what `h.rekey` does
> with Facets, and since Ruby 3.0 both also accept a hash that maps old keys
> to new ones. Facets' `Hash#rekey` is still there, and with no arguments it
> still converts every key to a Symbol.

The Hash may well be the most used class in Ruby. Sure, our programs
have arrays and strings galore, but they generally come and go without
much ado. Hashes on the other hand get *used*; and by that I mean to
say, we spend a lot of time fussing with them. I think there are two
significant reasons for this and I will focus on the first, and
the more important of the two, here.

Now, I suspect you would agree, if I were to present you with a class
which was clearly overkill for vast majority of its intended uses, and
its use required repeated mitigation of its unused features, I have no
doubt, you'd unequivocally advise me to select a "<i>better tool for the job</i>".
And yet, that's the situation all Ruby programmers face, day in and
day out, with Ruby's Hash.

Ruby's Hash is exceptionally powerful because it supports any type of
object as a hash key. That's really really cool... for all of about
five minutes. The truth is, the vast majority of cases only require
one type of key --for Ruby that will either be a Symbol or a String,
and because of this, a great deal of time and code is wasted ensuring
all keys are that single type. Because of this, methods like 
<code>#to_sym</code> often riddle our scripts.

The issue is undeniably attested to by real world "solutions"
others have created to address it, such as Ruby Facets'
<a href="https://web.archive.org/web/20081006134356/http://facets.rubyforge.org:80/doc/api/core/classes/Hash.html#M000124">Hash#rekey</a>
and Ruby on Rails'
<a href="https://api.rubyonrails.org/classes/ActiveSupport/HashWithIndifferentAccess.html">HashWithIndifferentAccess</a>.
But let's face it, these are both underwhelming attempts at mitigating
the fundamental problem.

A real solution would have the current Hash class renamed, and a new
limited-key structure put in its place. The old class would still be
available, of course, for those special cases when a key of any object
type is required, but the new, more utilitarian Hash class would be
the literally-constructed default. The end effect of this change would
be simple:

```ruby
h['a'] == h[:a]
h['1'] == h[1]
```

This means reducing all hash keys to a single *symbolic* index type.
It does not matter what the actual reference is, a String, Symbol,
Integer, etc. just so long as it has a predictable symbolic
representation.

It may feel a bit strange to consider a suggestion that actually calls
for the reduction of features. More often change requests call for just
the opposite and YAGNI has to be peddled out on them. But, I think, we 
often underestimate the power of simplicity. Consider ideas such as 
convention-over-configuration and duck-typing --simplifications that
are not necessarily intuitive at first. But in the end, they make our
life as programmers a good bit more productive.

<blockquote>
"Make everything as simple as possible, but not simpler."
<cite>--Albert Einstein</cite>
</blockquote>

<!--
title      : This Old Hash
author     : trans
date       : 2008-10-06
categories : [ruby, hash]
layout     : post
-->
