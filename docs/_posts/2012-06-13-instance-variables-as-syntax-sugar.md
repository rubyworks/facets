---
title: Instance Variables as Syntax Sugar
date: 2012-06-13
---

> **Update, November 2026:** Ruby never adopted `@` as a hash. A bare `@` is still a syntax error, and `instance_variable_get` and `instance_variable_set` are still the way to reach an instance variable by name. Ruby 2.6 did make the serialization loop below a little shorter, since `to_h` now takes a block: `instance_variables.to_h { |var| [var, instance_variable_get(var)] }`. At the time of this post, Facets offered something close to the idea as a method rather than syntax: `Kernel#instance` returned an object with `[]`, `[]=`, `each` and `to_h` over an object's instance variables. It was spun off as the `instance` gem in 2014 and is no longer part of Facets.

What are instance variables? If we think of them as a single unit we note that they represent an object *state*, which as a data structure is really nothing more than a *hash*. Indeed, it is quite feasible to forgo the use of instance variables altogether save one, to serve as the object's state.

```ruby
class Example
  def self.attr_reader(name)
    define_method(name){ @state[name.to_sym] }
  end

  def self.attr_writer(name)
    define_method("#{name}="){ |v| @state[name.to_sym] = v }
  end

  def self.attr_accessor(name)
    attr_reader(name)
    attr_writer(name)
  end

  def initialize
    @state = {}
  end
end
```

So if instance variables are essentially a hash, why is it that we cannot work with them as such? In other words, why not have `@` just represent a syntax sugar for a special hash (even if it's not a standard Ruby Hash instance under the hood, it can behave as if it were). With such a change, handling instance variables immediately becomes much easier and intuitive since we can apply all our knowledge of hashes.

Some neat capabilities immediately become apparent. Looking up an instance variable given a variable name can be done with:

```ruby
@[name]
```

Assigning an instance variable likewise can be done with:

```ruby
@[name] = value
```

No longer would the long-winded `instance_variable_get` and `instance_variable_set` be needed.

Let's take a more complex example. Have you ever wanted to reproduce the name and values of an object instance variable? It's not uncommon really. Any type of object serialization is going to need such a routine -- YAML, Marshal, etc. To do this presently requires some verbose code:

```ruby
hash = {}
instance_variables.each do |var|
  hash[var] = instance_variable_get(var)
end
hash
```

But with `@` sugar we can simply use:

```ruby
hash = @.to_h
```

Or if we just want to iterate over them:

```ruby
@.each do |k,v|
  ...
end
```

Since we have #each, then all Enumerable methods would be at our disposal.

For a public interface `instance_variables` could reference the internal `@` instead of just the list of instance variable names. We could deprecate `#instance_variable_get` and `#instance_variable_set` altogether.

By recognizing the nature of instance variables and applying the preexisting functionality of Hash, we gain much greater capability while using fewer brain cells to do it. And that's always a win.
