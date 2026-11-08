---
title: From Singleton to Legion
date: 2006-07-22
---

> **Update, November 2026:** Ruby 1.9.2 added `Kernel#singleton_class`,
> which made "singleton class" the official name. Ruby still keeps a single
> singleton class per object, so on an unpatched Ruby the second `def o.x`
> below replaces the first, and its `super` raises `NoMethodError`. But
> Ruby 2.0 added `Module#prepend`, and prepending a module to the singleton
> class gives much the same layering: after
> `o.singleton_class.prepend(Module.new { def x; super + "x"; end })`,
> `o.x` returns `"xx"`. Facets carried both `eigenclass` and `qua_class` as
> `Kernel` methods. Facets 3.2 deprecated them in favor of `singleton_class`
> or Facets' `meta_class`, and they will be removed after 2027-09-30.

<!-- ---
title: From Singleton to Legion
date: "2016-07-22"
by: trans
description: Ruby's Singleton classes need not be so alone
-->

For as long as I've coded Ruby there has been some question as to the appropriateness of the term *singleton class*. This is the term generally used in Ruby parlance to refer to the language construct: `class << obj; self; end`, and is the context of class methods and module methods.

While the term is fitting in the sense that each object only has one of these classes (hence "single"), issues arise from a terminology clash with an already well accepted object-oriented programming term, [Singleton Pattern](http://en.wikipedia.org/wiki/Singleton_pattern). In OOP-speak a singleton class is a class that can only be instantiated once. Many have argued that the Singleton pattern itself is a flawed concept, since one can just instantiate an object and assign it to a constant to achieve the same end. So why restrict anyone from a second instance of a class if they so choose? That's a reasonable argument, although not always as practical as it might seem. Nonetheless, the terminology clash still remains.

In light of nomenclature issue, many have offered alternative terms for Ruby's singleton class. Indeed, Ruby itself has used two alternatives in the past: virtual class and metaclass, and many people still prefer the latter of these choices. Other suggestions include the well known _whyism `eigenclass`, the abbreviated `sclass`, the pronoun contingents 'myclass' and 'ownclass', as well as my own concoctions `adhoc` and `qua_class`. Yet despite all these names, none of which ever stick, what is this singly thing really?

Recently, our beloved Pit Capitain put it concisely when he said "there are only two types of methods in Ruby, instance methods and singleton methods". Well said. Unfortunately it's not quite true. Instance methods aren't really methods at all, they are just definitions for methods to be. That's why when you use `#instance_method` you get something called an `UnboundMethod`, not a `Method`. It only becomes a method when it's bound to an object. To clarify further how that distinction is a bit misleading, consider that when a singleton method is defined it falls into an inheritance hierarchy alongside so-called instance methods. In other words, the singleton methods and instance methods exist on the same playing field, and the former can call on the other via `#super`. In fact, we can access these singleton methods in instance fashion via `(class<<obj;self;end).instance_method(sym)`. So these methods are not really distinct in this manner after all. In fact there is no distinction between methods other than bound and unbound. And this distinction arises from the capability of class Module and class Class to harbor a set of method definitions that are not their own. Which is of course exactly why these constructs exist in the first place. So when we say singleton method, we are not referring to something different from instance method. We only mean that these methods are kept in a special "singleton class", made just for a specific object, and consequently, are automatically bound to that object.

Now, I'm going to claim that the term 'singleton' is a poor choice for a completely different reason than any given before. It may come as a bit of surprise, but singletons are not inherently single. They are only made so by an explicit restriction in Ruby's source code. It is quite simple, actually, to remark-out the if-clause from the source, recompile Ruby and then do:

```ruby
o = Object.new
def o.x
  "x"
end
def o.x
  super + "x"
end
o.x   => "xx"
```

The reason Ruby makes the per-object classes single is because it would be terribly inefficient to define a whole new class for every new singleton method defined. That's understandable, but it also comes at a cost. We can not reliably receive an object from the outside world and define our own singleton on it because we may be clobbering someone else's singleton method without even knowing it. (NOTE: It doesn't matter so much if you're just redefining a method altogether, but if you're calling super it very much matters.) Generally we don't even think about such things, but truth be told, object singleton methods often fail to survive code refactoring. Object singletons really only exist as a side effect of Ruby's class model (and Smalltalk's?) which utilize the singleton class as a means of separating a module/class method definitions from its own actual methods. This could have been done another way of course, but then a class/module would be something wholly different from any other object. The use of the singleton allowed classes and modules to be just like any other object. So singletons are really a bit of cleverness that lie at the very heart of how Ruby works.

Does it mean that they have to be singly? Could we remove the restriction and open up an additional robustness to these per-object classes? We could. In fact, this was the very first hack I ever made to the Ruby source code. My change simply checked to see if the method was already defined in the first "singleton" layer and continue upward until it either found a usable layer or ran out of layers, in which case it created a new one. Combined with the capability to selectively undefine particular methods of particular layers and we gain a flexible per-object class hierarchy system that can be used without the caveats that currently make singletons so limited outside of class and module definitions.

And then we no longer can call them "singleton" but rather "legion" ;)
