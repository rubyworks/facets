---
title: The Persnickety Order of Self-Serving Modules
date: 2006-08-26
published: false
---

This one caught me off guard.

```
irb(main):001:0> module M
orb(main):002:1>   def x; "x"; end
orb(main):003:1> end
=> nil
orb(main):005:0> module Q
orb(main):006:1>   extend self
orb(main):007:1>   include M
orb(main):008:1> end
=> Q
orb(main):009:0> Q.x
NoMethodError: undefined method `x' for Q:Module
        from (orb):9
        from :0
```

Why isn't the included #x coming along for the ride in the self extension of Q? This kind of dyanmicism is vital when dynamically loading behaviors. And so I suspect it must do with the dread [Dynamic Module Inclusion Problem](http://groups.google.com/group/comp.lang.ruby/msg/70509b289f0ea999)? And it would appear that I am right:

```
orb(main):012:0> module M
orb(main):013:1>   def x; "x"; end
orb(main):014:1> end
=> nil
orb(main):015:0> module Q
orb(main):016:1>   include M
orb(main):017:1>   extend self
orb(main):018:1> end
=> Q
orb(main):019:0> Q.x
=> "x"
```

Yes, another of the edge cases. But the preponderance weighs heavy on the Coding Spirit. The Dynamic Module Inclusion Problem is getting old.
