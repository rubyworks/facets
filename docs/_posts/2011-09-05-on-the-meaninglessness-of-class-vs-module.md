---
title: The Meaninglessness of Class vs Module
date: 2011-09-05
published: false
---

> **Update, November 2026:** Nothing has changed here: included modules still come before the superclass, and a class still can't be included. Facets offers the `Module#new` trick at the end as the `Instantiable` mixin.

# Fear Not the Wereclass

**DRAFT**

In the spirit of Halloween, let's take the fun example of the Werewolf. Let's say we already have classes for Man and Wolf at our disposal --some very smart programmer already did the hard work for us and developed these definitive representations ;)

```ruby
class Man
  def shoot_gun
    puts "Bang!"
  end
  def give_chase
    puts "After it!"
  end
end

class Wolf
  def howl
    puts "Awoooooooo"
  end
  def give_chase
    puts "Woosh!"
  end
end
```

Now what about our Werewolf? Half-man and half-wolf, what superclass do we use in its case? Most classes have a clear superclass, but some, such as our werewolf, are not as clear-cut. Perhaps we decide that a werewolf in our universe is more like a wolf than a man, so:

```ruby
class Werewolf < Wolf
end
```

But we are still left to add Man's qualities. Ruby gives us no easy way to do this given our original classes. So we are forced to refactor the former Man class into a module.

```ruby
module ManLike
  def shoot_gun
    puts "Bang!"
  end
  def give_chase
    puts "After it!"
  end
end

class Man
  include ManLike
end

class Werewolf < Wolf
  include ManLike
end
```

Well there you go, a bit long winded perhaps, but it does the deed. But hang on. It appears things are a bit worse off than we might have suspected. We thought by using Wolf as the superclass we were saying a werewolf is essentially a wolf, but with some man like qualities. Surely that is what it must mean for a Werewolf to be a subclass of a Wolf. Unfortunately we would be wrong. When we ask a werewolf to `give_chase`, we discover it is doing it in quite the manly way, not the wolfly way.

```ruby
werewolf = Werewolf.new
werewolf.give_chase  #=> "After it!"
```

Oh dear, that's not good. The difference lies in the order of lookup. If two methods conflict, guess which one takes precedence? Would you be surprised to know that it is not the superclass, but rather the mixin?

Well, it doesn't make a great deal of sense, but clearly we have no choice, we must refactor again.

```ruby
module WolfLike
  def howl
    puts "Awoooooooo"
  end
  def give_chase
    puts "Woosh!"
  end
end

class Wolf
  include WolfLike
end

class Werewolf < Man
  include WolfLike
end
```

Well, there we are. Not our ideal conception of things, clearly, but it <i>does what we need it to do</i>... Of course, in the real world the original classes are not necessarily under our control, leading us to the only and unenviable option of re-implementing everything. What a waste.

The fact that Ruby's inheritance system in conjunction with its mixin system produces a wonky order to method look-up; the fact that we can't *reuse* a class as a module when we might have need to do so; and the fact that we are left then only to do things in unseemly manners and duplicating lots of code too, well, to put it's all a bit frightful. But really, it's not just our coding that becomes strained and more difficult --after all we are programmers, we "work around". What really is a shame is that it severely limits the utility of Ruby's inheritance model and contributes in no small part as to why we see so little *semantic* subclassing in Ruby programs, as opposed to the simplistic base-class designs that we frequently see.

The fact is the division between class and module is essentially arbitrary.

Consider this little trick:

```ruby
class Module
  def new(*a,&b)
    c = Class.new
    c.include self
    c.new(*a,&b)
  end
end
```

The distinction between a module and a class in Ruby is purely a superficial one that has been hard coded into the language for no utilitarian reason. It is there only as an artifact of the original conceptualization.

Removing the distinction of class vs module has nothing to do with multiple inheritance. Classes still only have a single superclass. Rather it is the principle of ... that is being violated. There is no need for a module to know it's a module or class to know it's a class. Both are merely encapsulations. What matters is how they are used.

There is also a wonderful side benefit from this removal. Load order would no longer matter when two different scripts attempt to utilize the same namespace.

Now I can all but guarantee that at some point someone, who very likely hasn't read this entire post, is going to say "use delegation". Yes, yes. I am a big fan of delegation myself. But that is not what this article is about. It is about the utilization of Ruby's inheritance and mixin system. If delegation were always the answer then we might as well flush the whole inheritance and mixin things down the drain and use delegation for everything. But that's a different debate. The question here is, if we are going to have inheritance and mixins, then obviously we should make the greatest use of them.
