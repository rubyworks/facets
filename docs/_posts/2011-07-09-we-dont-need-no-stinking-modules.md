---
title: We Don't Need no Stinking Modules
date: 2011-07-09
published: false
---

> **Update, November 2026:** Ruby 2.0 didn't get `Module#mix` after all: it was added to Ruby's development code, then reverted in June 2012, before 2.0 came out. Since Ruby 3.0, keyword arguments are kept apart from positional ones, so the `method_missing` below no longer passes keywords along unless it takes a `**kw` parameter too. And for `respond_to?` to report the delegated methods, an object also needs a `respond_to_missing?` method (Ruby 1.9.2 and later). I fixed the code samples: neither set up `@_delegates`, so any missing method sent them into endless recursion, and the second called an undefined `delegates` method.

Among experienced developers you will hear no end of praise for delegation. All things considered, it is the most powerful, flexible and controllable means of incorporating reusable behaviors. Even so, I recollect that I once read, no object-oriented programming language utilized delegation as its only means of handling modules.

With the talk of Ruby 2.0 supporting the concept of Module#mix (essentially a traits system), I can't help but wonder why bother. In fact, I have a bit of code for you to consider.

```ruby
class Object
  def use(delegate)
    (@_delegates ||= []) << delegate
  end

  def method_missing(s,*a,&b)
    delegate = (@_delegates || []).find{ |d| d.respond_to?(s) }
    if delegate
      delegate.send(s,*a,&b)
    else
      super(s,*a,&b)
    end
  end
end
```

And here we have the basis of a delegate-based reusable component system. Of course, we need to work this at the class level too, if we want to move past Prototype-based OOP. That's not difficult, we just use a class level delegate store, and override #new to insert the delegates on initialization.

```ruby
class Object
  def self.use(delegate)
    class_delegates << delegate
  end

  def self.class_delegates
    @_delegates ||= []
  end

  def use(delegate)
    (@_delegates ||= []) << delegate
  end

  def method_missing(s,*a,&b)
    delegate = (self.class.class_delegates + (@_delegates || [])).find{ |d| d.respond_to?(s) }
    if delegate
      delegate.send(s,*a,&b)
    else
      super(s,*a,&b)
    end
  end
end
```

Is there really anything else that we need? Okay sure, it needs to be beefed-up, to do things like "inherit" delegates from superclasses, but as the basis of such a system, it's square.

Now the caveats.

* It's not going to be very fast having to "find" the methods like this every time. Granted. But I suspect that an optimized version of this could be implemented in Ruby itself, mitigating most if not all of that.

* The delegate has no access to the delegator's state. This is a serious issue for mixins like Enumerable. This could be fixed by giving the delegate access to the delegator. Since a delegate can be reused by other objects, this would require duplicating each delegate, or wrapping it in a special container instance, and passing it a reference to the delegator. That would be pretty inefficient though. Better would be a dynamic means of access handled by the Ruby interpreter itself. 

