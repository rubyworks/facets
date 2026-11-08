---
title: If and OOPY If
date: 2008-09-28
---

> **Update, November 2026:** Ruby still treats only `nil` and `false` as false. The safe navigation operator, `&.`, added in Ruby 2.3, covers some of what I wanted `null` for. Facets does have a `NullClass`, but it's still true in a condition.

Ruby takes a unique approach to conditional evaluation: <i>All
objects are equivalent to `true` except `nil`
and `false`</i>. No doubt this is a more object-oriented
approach than, say, C's use of `0` as false, but it's far
from the ideal of OOP all the way down, as any
<a href="http://pozorvlak.livejournal.com/94558.html">Smalltalker</a>
can attest.

Consider the following case. For a while now, I have wanted in my arsenal
of Ruby classes a NullClass defined basically as:

```ruby
class NullClass
  def method_missing(*a)
    self
  end
end

NULL = NullClass.new

def null
  NULL
end
```

This object would greatly benefit fluent interfaces. Instead of returning
`nil`, such interfaces could return `null`, and no 
error would be thrown when invoking any method against it.

```ruby
obj = null
obj.it.does.not.matter  #=> null
```

Unfortunately `null` is not very viable in Ruby
because `null` still evaluates as `true`
when used as the expression of a condition. The fact remains,
Ruby is hardcoded to see only the singleton instances of 
`NilClass` and `FalseClass` as false.

I've requested that `NullClass` be added to core Ruby in
the past (as of yet to no avail) and though I still would like to
see it included, it may be better still to take an altogether 
object-oriented approach to conditions --in the spirit of Smalltalk.
This would allow us to freely create "false" objects, like the
`NullClass`, ourselves.

The adoption of such a capability does not require the odd syntax 
used by Smalltalk (`ifTrue` / `ifFalse`).
Rather, it can take an approach more akin to Ruby's own `case`
statements. As with `case`'s use of `#===`,
a particular method would be used to evaluate the "truthiness" of
a value. This would apply for all types of conditions: 
`while`, `until`, etc. 

To clarify, let's say this special method is simply called #if, then...

```ruby
class IfExample
  attr :if
  def initialize(value)
    @if = value
  end
end

x = IfExample.new(false)

if x
  "Yes"
else
  "No"
end
```

The result of this condition would be `"No"`.

While it may not be an earth shattering adjustment, the additional
flexibility opens up some interesting doors. Not only would classes
like the previously mentioned `NullClass` become possible,
but conditions themselves become <i>dynamically controllable</i>.

For example, it would allow method probes to fully map method
signatures (the Halting Problem notwithstanding). This is not 
currently possible in Ruby because a probe cannot pretend to evaluate
to false in order to walk through the false side of a condition.

The idea would require some getting used to --after all a simple 
if-statement would no longer do what we Rubyists presently take 
for granted. But then, that's the nature of progress, is it not?

<!--
title      : If and OOPy If
author     : trans
date       : 2008-09-28
categories : [ruby, nullclass]
layout     : post
-->
