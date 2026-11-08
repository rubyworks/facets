---
title: The Persnickety Order of Self-Serving Modules
date: 2006-08-26
---

> **Update, November 2026:** Ruby 3.0 fixed this
> ([#9573](https://bugs.ruby-lang.org/issues/9573)). Including a module now
> also reaches the classes and modules that already included the receiver,
> and that covers `Q`'s singleton class, which got `Q` through `extend self`.
> So on Ruby 3.0 and later, `Q.x` returns `"x"` whichever order the two
> lines come in. I've fixed the irb prompts in the transcripts below, which
> read `orb`.

This one caught me off guard.

```
irb(main):001:0> module M
irb(main):002:1>   def x; "x"; end
irb(main):003:1> end
=> nil
irb(main):005:0> module Q
irb(main):006:1>   extend self
irb(main):007:1>   include M
irb(main):008:1> end
=> Q
irb(main):009:0> Q.x
NoMethodError: undefined method `x' for Q:Module
        from (irb):9
        from :0
```

Why isn't the included #x coming along for the ride in the self extension of Q? This kind of dynamicism is vital when dynamically loading behaviors. And so I suspect it must have to do with the dread [Dynamic Module Inclusion Problem](http://groups.google.com/group/comp.lang.ruby/msg/70509b289f0ea999)? And it would appear that I am right:

```
irb(main):012:0> module M
irb(main):013:1>   def x; "x"; end
irb(main):014:1> end
=> nil
irb(main):015:0> module Q
irb(main):016:1>   include M
irb(main):017:1>   extend self
irb(main):018:1> end
=> Q
irb(main):019:0> Q.x
=> "x"
```

Yes, another of the edge cases. But the preponderance weighs heavy on the Coding Spirit. The Dynamic Module Inclusion Problem is getting old.
