---
title: Main is a DRY Pain
date: 2006-08-17
published: false
---

<!-- ---
title: Main is a DRY Pain
date: "2006-08-17"
-->

I have a module that depends on define_method and ancestors. It works great when I include it in other modules or classes. But if I try including it into the toplevel it fails miserably.

    NameError: undefined local variable or method `define_method' for main:Object

That seems fairly peculiar when you consider that defining methods at toplevel is perfectly acceptable. One must then wonder, what is this toplevel thing anyway?

```ruby
self    #=> main
```

Okay, it calls itself "main". Great. But that doesn't really tell us anything. Let's check it's class:

```ruby
self.class  #=> Object
```

Ah. So it's an instance of Object. An instance of Object! How is that possible? A normal instance of Object and main can't be exactly the same. Indeed, they are not.

```ruby
(public_methods - Object.public_instance_methods).sort
#=> ["include", "private", "public"]
singleton_methods
#=> ["include", "private", "public", "to_s"]
```

Notice include has been defined here specifically for main. So something special's going on when you include a module into the toplevel. Hmm... What about methods defined at the toplevel? If main is an instance of Object then are they singleton methods? Well, no. Turns out they get "magically" defined as private methods of the Object class itself, and main's singleton class space is actually something else entirely.

```ruby
class << self
  def x; "x"; end
end

class Q
  def q; x; end
end

Q.new.q
#=> NameError: undefined local variable or method 's' for #<Q:0xb7ce9a3c>
```

Which means the sure solution for my problem...

```ruby
module Kernel
  include MyModule
end
```

Can you guess?

```ruby
module M
  def m; "m"; end
end

module Kernel
  include M
end

m
#=> NameError: undefined local variable or method `m' for main:Object

class Q
  def q; m; end
end

Q.new.q
#=> NameError: undefined local variable or method `m' for #<Q:0xb7cbb324>
```

Lands me squre in the face of the Module Inclusion Problem.

All this leads me to two points. First, I'm stuck! There seems to be no solution to my problem other than rewriting a second version of my module specifically for the toplevel. Talk about lack of DRY! And 2) Why in the world isn't main a self extended module?
