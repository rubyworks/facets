---
title: Is it an Attribute?
date: 2011-09-10
---

> **Update, November 2026:** Since Ruby 3.0, `attr`, `attr_reader`,
> `attr_writer` and `attr_accessor` return the names of the methods they
> define, so they can be handed to a visibility declaration, as in
> `private attr_reader :bar`. They still only define methods, though; Ruby
> has no way to declare an existing method an attribute. The "method
> redefined" warning mentioned below only appears when warnings are turned
> on, with `ruby -w`, as was already the case in 2011. RDoc 6.14, the
> version that comes with Ruby 3.4, still documents the `Foo` and
> `IsItAnAttribute` examples just as described. I've corrected the comments
> on `bar` and `baz` in the `IsItAnAttribute` example, which were labeled
> `#foo`.

What exactly is an attribute? From the standpoint of OOP, a Ruby attribute is 
intended to be what is generally referred to as an <i>accessor method</i>.
An accessor method is a means of direct access to an object's underlying state.
In other words, it is a method for direct access to an instance variable. And
that is exactly what Ruby's helper class methods, i.e. `attr`, `attr_reader`,
`attr_writer` and `attr_accessor`, achieve.

However, Ruby's "accessor methods" are not specially recognized methods, 
(as are *properties* in Javascript, for example). Rather Ruby simply creates
regular old methods which internally work with an instance variable. This
fact leads to a bit of puzzlement. If attributes are Ruby's means for creating 
accessor methods, but attributes are only a short-cut for creating regular
methods, when then is a method an attribute or not an attribute?  For instance:

```ruby
class Foo
  def x; @x; end
end
```

Is `#x` an attribute in this example since it results in the exact same 
class definition as:

```ruby
class Foo
  attr :x
end
```

It would seem to be, but neither RDoc or YARD will document it as such, even though
both list attributes of a class.

Going a step further, if the latter definition *is* an attribute, which is an accessor
method, what then is:

    class Foo
      def x; @x.to_s; end
    end

Does the addition of #to_s invalidate #x as an accessor and thus as an attribute?
Is that the case even if @x is *supposed* to be a string?

More confusing still, since Ruby methods can be rewritten at any time, there is the 
opposite possibility that what appears as an attribute is not actually an accessor
method at all. Experienced Rubyists know that Ruby issues a warning when a method
overwrites another method --even one created via an `attr` method. But it's just
a warning and a fairly minor one at that. This can cause some very basic
confusion if an attribute is overwritten by a method.

Ruby's common documentation tools make this issue very easy to see. Take a class
defined as follows:

    class IsItAnAttribute
      # Attribute accessor #foo.
      attr_accessor :foo

      # Attribute reader #bar.
      attr_reader :bar

      # Attribute writer #baz.
      attr_writer :baz

      # Method #foo.
      def foo; @foo + 1; end

      # Method #foo=.
      def foo=(i); @foo = i.to_i - 1; end

      # Method #bar.
      def bar; end

      # Method #bar=(i)
      def bar=(i); @bar = i; end

      # Method #baz.
      def baz; @baz; end
    end

In the case of RDoc,
it lists `bar=`, `baz` and `foo=` as methods, and `bar[R]`, `baz[W]`
and `foo[RW]` as attributes. The attributes seem reasonable if we simply
take it on faith that attribute declarations are accessors regardless of
what the methods might be doing --it's the documentors issue. And maybe that
is all we can reasonably expect. But it is odd that #bar is missing from the
method definitions.

YARD on the other hand,
also lists `bar`, `baz` and `foo` as attributes, but does not make
it clear if they are readers, writers or both. It also lists `bar`, `baz`
and `foo` as methods, with no indication that writers even exist. YARD has
some attribute related tags for this, but what seems like the proper approach
to improve the documentation appears to do nothing new.

    # Method #bar.
    # @attribute r bar
    def bar
    end

(And I would add, there is no `[view source]` link in this case as well.)

So what gives? What really is an attribute? I'm inclined to think we might need
to throw out the whole concept from Ruby, at least as Ruby now stands. Attributes
are nothing more than a meta-programming device to create methods and it's
impossible to ensure documentation only labels methods that behave as 
accessor methods.

On the other hand, perhaps we should redefine that concept of an attribute,
not as an accessor method, but as any method we want it to be so long as it
accesses an instance variable in some form or fashion (albeit enforcing that
is not strictly possible either). In that case it might be worth adjusting
the attr methods to act as *declarations* rather than merely meta-methods.
In this way any method could be declared an attribute in the same way that
methods can be declared public, private or protected.

<!--
title      : Is it an Attribute?
author     : trans
categories : [attributes, oop]
date       : 2011-09-10
layout     : post
-->
