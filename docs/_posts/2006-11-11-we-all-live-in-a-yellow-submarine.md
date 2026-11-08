---
title: We All Live in a Yellow Submarine
date: 2006-11-11
published: false
---

Anyone having read my previous posts, here and on ruby-talk, knows I love to explore ideas. It doesn't matter if they are considered "good" or "bad". Most cannot be judged without first exponding on them anyway. In fact, half the time I have no idea where an idea might lead until I sit down and blog it.

Tonight's idea comes by way of frustration with project organization, specifically module namespaces. A minor issue for small projects; large projects on the other hand... Well, consider my current problem. I have a class called Project. Now related to Project are a number of modularized tool sets. Each tool set can be used independently of the Project class, but typically will be used via it. So where do I locate the tool sets? My first instinct is to go ahead and put them in the class itself.

```ruby
module MyApp
  class Project
    module ToolSetA
    module ToolSetB
```

But I find this less the optimal. While it may be a small and unlikely matter, class is not a bonofide namespace --it is a class. And while it depends on these tool sets, the tool sets do not necessarily depend on it. As such we would never be able to include these tool sets in another namespace --such as the toplevel if it struck my or some users fancy. So we are left then to use some alternate organization.

```ruby
class Project
module ProjectToolsets
  module ToolSetA
  module ToolSetB
```

or as a compromise

```ruby
class Project
  module Toolsets
    module ToolSetA
    module ToolSetB
```

The downside here, of course, are the long-winded names. But a better solution eludes me, other than one possibility: the use of all capitals for pure namespace modules.

```ruby
class Project
module PROJECT
  module ToolSetA
  module ToolSetB
```

It's a bit strange in appearance but it works well. One quark however is that this new rule begs for my project's toplevel namepsace to be all caps too. Do I want to go there?

```ruby
module MYAPP
 class Project
 module PROJECT
   module ToolSetA
   module ToolSetB
```

I'm not sure it's the solution I'm after, but to its merit, it does draw a nice distinction between namespace modules and other modules and classes.

In the course of this consideration I began to wonder about the distinction between Class and Module. The difference is almost not-existent in reality. If you peer into the Ruby source code you will find that interoperability between them is purposefully prevented. After all Class is a subclass of Module. Yet they are made distinct for a good reason. They provide conceptually different ideas. A class represents an data archetype; a module represents a reusable component. In fact, one could easily argue that Module itself could use an additional distiction between Namespace and Mixin. Even so, I could not help but wonder if it might yet be possible to have a single Encapsulation, relegating the differences to the elements within them instead of the encapsulation types themselves. I imagined this:

```ruby
class Something
  def x
  def y
  mod_def a
  mod_def x
  class SomethingElse
```

Instantiating via Something.new or subclassing would provide the instance methods x and y. Including however would provide the mod_def methods a and x instead along with adding SomethingElse to the including namespace. More refined means of controlling namespace become possible. For instance include_constants could limit inclusion to constants only; vice-verse with include_methods. Methods could be defined as both instance and module methods. And while we're at it, throw in a class_def as an alternative to def self.x.

It's interesting. I've often thought about the idea of eliminating the distinction between Class and Module. This is the first time it's occurred to me that it could be done while retaining the utility of that distinction by passing responsibility down to the methods themselves.

I suppose now the question is, what are the downsides to this? That'll require further consideration, but one clear point is that methods are less cleanly divided. You could have module methods scattered about your class definitions, weaving in and out of your instance methods. I suspect we would make an effort to nicely organize them however. Besides it means having fewer modules to name --and I'm all for anything that reduces the number of names I have to make-up.

It would be interesting to see how far one could go in implementing this in pure Ruby. Some details of Ruby will hold back a perfect implementation, but the essence of it is certainly possible. For starters, here's a neat trick for doing without the distinction between class and module.

```ruby
class Module
  def new
    mod = self
    Class.new{ include mod }.new
  end
end
```

Have fun! Unfortunately I'm not. I'm still stuck on the forementioned namespace issue! Oh well. Back to the coding board...
