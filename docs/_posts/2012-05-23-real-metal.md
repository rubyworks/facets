---
title: Real Metal
date: 2012-05-23
---

> **Update, November 2026:** Ruby 2.0 removed the third shortcoming mentioned below: a method taken from a module, such as `Kernel.instance_method(:class)`, can now be bound to any object, including a BasicObject, so `$meta[BasicObject.new].class` returns `BasicObject`. Ruby 2.7 added `UnboundMethod#bind_call`, which does what `bind(obj).call` does without creating an intermediate Method object, so `Kernel.instance_method(:class).bind_call(obj)` gives an object's real class even when `#class` is overridden. Ruby has not adopted the `$` notation suggested here. Facets' own `Kernel#meta` (the 3.0 name for `Kernel#eigen`) is unrelated: it sends messages to an object's singleton class. I also corrected the result shown for `obj$class`, which should be `Object`.

One of the most regarded capabilities of Ruby, in contrast to many other programming languages, is its powerful meta-programming chops. While not every aspect of the language is meta-programmable, the vast majority of Ruby is. But despite its prowess, there is a serious weakness in its design: _The functions on which meta-coders depend have no guarantee_. 

Consider the most basic reflection method of determining the class of an object, fundamental to almost any meta-programming (and some not-so-meta-programming). We can write a class that completely subverts the ability to determine an object's class.

```ruby
class Foo
  def class
    "I Confuse You!"
  end
end
```

Because `Foo` has overridden the `#class` method, there is no way to determine the class of an instance of Foo. Any code dependent on the `#class` method "contract" is going to choke.

We can be thankful that most programs will, by simple happenstance, never tread on any of these important methods. In the few cases where they might, most Ruby coders are aware enough to steer clear. Yet there are other cases not so easily handled. Consider Ruby's relatively new BasicObject class. It has the minimal number of methods necessary to function as an object in Ruby. This is excellent for the construction of open classes akin to OpenStruct, but consequently there is no way to find out what methods are defined on such an object because there is no such methods as `#methods` or `#instance_methods`. Moreover, BasicObject is still not completely empty. It still defines `__id__`, `__send__`, `instance_eval`, `instance_exec` and a few others, without which an object simply wouldn't be usable.

So basically Ruby has settled on a "close enough" approach to handling reflection and meta-programming. But why should we be willing to settle for any risk at all? The reasoning I have most often heard is an OOPL ideological principle arguing that no method should stand outside the realm of the inheritance chain, and thus all methods are necessarily subject to overrides. But I am not convinced for the simple reason that meta-programming is by its nature "_meta_".

As an experiment, I developed a small library to take the risk out of meta-coding. The library basically works as follows:

```ruby
$meta = Proc.new do |obj|
  Functor.new do |op, *a, &b|
    Kernel.instance_method(op).bind(obj).call(*a, &b)
  end
end

$meta["some string"].class #=> String
```

This meta-function works fairly well in most cases. However it has three shortcomings that make it essentially impractical for production use: 1) It lacks module methods; 2) It is terribly inefficient; and 3) It doesn't work for BasicObject instances.

While my little library might be improved upon, ideally Ruby would provide a set of "meta-functions" that cannot be overridden in-class. These methods could all be defined in a special module, but used via alternate notation so as not to conflict with ordinary methods. To that end I suggest using `$` on regular objects:

```ruby
obj = Object.new
obj$class #=> Object
```

Numerous other methods would be made available through this, in general all public Kernel methods are candidates for inclusion, and some Module methods usable just for classes and modules, such as `#instance_methods`.

The robustness this would bring to Ruby's meta-programming would be a great boon and should not be understated. When a single line of code can so easily cause every object in a program to fail, it's not unreasonable to prefer some guarantees. Moreover, it makes the meta-programmer's task much easier --he knows exactly what methods on which to depend.
