---
title: Ruby AOP Made Simple
date: 2010-10-13
---

> **Update, November 2026:** Ruby 2.0 added `Module#prepend`, and it works
> as proposed here: the first example runs as written. The Joinable trick
> still works too. But now that `prepend` is built in, the `Module` override
> at the end of this post would replace Ruby's own `prepend`, so prepending
> to any class or module without a `Joinable` would raise an error. I have
> since proposed ([Feature #22513](https://bugs.ruby-lang.org/issues/22513))
> that `Kernel#extend` and `Module#prepend` take a block, evaluated in a new
> anonymous module, so a module like `A` could be written in place with
> `C.prepend do ... end`.

<!-- ---
title: Ruby AOP Made Simple
author: trans
date: 2010-10-13
categories: [aop, cuts, ruby]
layout: post
-->

## Quick Recap

Aspect Oriented Programming (AOP) is a topic I have spent a fair amount of
time contemplating. I, along with Peter VanBroekhoven, developed
the concept of Cut-based AOP back in 2005-2006. A limited "toy" implementation of
which can be had by installing the `cuts` gem. The basic idea behind Cut-based
AOP is the <i>transparent subclass</i>, a.k.a. the _cut_, which is essentially
a subclass that subsumes the role of the class it effects without the programmer
needing any knowledge of it doing do. In this way, the cut serves as the atomic
construct in a purely object-oriented appraoch to AOP. You can read more about it
<a href="http://github.com/rubyworks/cuts/blob/master/RCR.textile">here</a>.

In dicussing this idea on the ruby-talk mailing list it was suggested that
an easier approach would be to forgo the Cut class and simply allow modules
to be "prepended" to the class or module to which they are applied. So for
instance we might write:

``` ruby
class C
  def x(s); "#{s}" ; end
end

module A
  def x(s); '{' + s + '}' ; end
end

class C
  prepend A
end

C.new.x('hello')  #=> "{hello}"
```

Cut-based AOP is a general OOP design that can be applied to any
object-oriented programming language. But for Ruby, the idea of `prepend`,
while more limited, does serve much of the same purpose, and the idea is up for 
consideration in a future verison of Ruby.

## Another Way

There is however another way to essentially use prepend-like AOP in Ruby without
extending Ruby in any special way. The trick is simply to design classes
and module to be "AOP-ready". Here is an example of the above using nothing
more than standard Ruby.

``` ruby
class C
  module Joinable
    def x(s); "#{s}" ; end
  end
  include Joinable
end

module A
  def x(s); '{' + s + '}' ; end
end

class C
  include A
end

C.new.x('hello')  #=> "{hello}"
```

Pretty easy. We have simply encapsulate C's instance methods in a "Joinable"
module, thus any new inclusions into C itself will actually come _before_
these methods.

This of course raises the issue of including modules in the normal fashion,
in which case we would need in include them in Joinable itself, e.g.

```ruby
class C
  module Joinable
    include Foo
  end
end
```

We could facilitate this will a little bit of Ruby magic.

``` ruby
class Module
  alias_method :_include, :include

  def include(*mods)
    if const_defined?(:Joinable)
      core = const_get(:Joinable)
      core._include(*mods)
    else
      _include(*mods)
    end
  end

  def prepend(*mods)
    if const_defined?(:Joinable)
      _include(*mods)
    else
      raise "#{self} is not Joinable"
    end
  end
end
```

This is a very simplistic implementation, but a robust implementation would
be only slightly more complex. Now, as along as we use <code>Joinable</code>,
we can use #prepend.

<!-- ---
title: Ruby AOP Made Simple
author:
  name: trans
date: 2010-10-13
categories: [aop, cuts, ruby]
layout: post
-->
