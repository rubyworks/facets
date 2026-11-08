---
title: Vote Kernel for Toplevel Object
date: 2006-08-18
---

> **Update, November 2026:** Ruby 2.0 did add a top-level `define_method`, much as matz suggests below. But `main` is still a stand-in for `Object`, not `Object` itself, so the example still prints `true` and `false`. I came back to the idea in [Kill the Proxy and Save Toplevel]({{ site.baseurl }}{% post_url 2012-06-17-kill-the-proxy-and-save-toplevel %}).

As a follow up to my last post on the "pain that is main", I want to offer a potential improvement for Ruby 2.0. I approached the topic on ruby-talk this week and while Matz initially took some interest, he hasn't followed up since his last comment:

    matz: Why?  If it is really required it's fairly
    easy to add toplevel methods like we did for #include.

But it isn't always easy. In order to get my Taskable module to work, for instance, I had to make exceptions for the toplevel case, which is far from ideal and is fragile [Ed- in fact I'm still getting bugs that I haven't yet pinned down]. These subtle difficulties arise because main acts as a partial proxy for the Object class. Anyone who has created a proxy object before knows the subtle issues that can come into play. In this case, only the bare minimal interface is supported --essentially the method #include. Yet, even if we take matz' advice and add in all the missing proxy methods, we still won't be 100% out of the woods. The Object class and main are fundamentally two distinct objects --self is not the same, nor are their singleton classes, &c. In the vast majority of cases this will never present an issue, but the distinction can creep in. Here's a highlight of one way it can:

```ruby
module Q
  define_method :q do
    base = self
    define_method :r do
      base == self.class
    end
  end
end

class C
  extend Q
  q
end

c = C.new
p c.r

# per matz' direction

def define_method( name, &act )
  Object.class_eval {
    define_method( name, &act )
    private name
  }
end

extend Q
q
p r
```

produces

```
true
false
```

So in effect Ruby is mildly schizophrenic. The false reading is because main != Object. So, you can't necessarily create a DSL for Object to be used in main, and you can't necessarily create a DSL for main to be used in any Object. Hence the devolution to DRYless code.

There is a potentially elegant solution however, and I'd really like to understand others' insights into this (especially Matz' of course): Instead of main being a special proxy object, just let it be a self extended module.

```ruby
module Main
  extend self
  # programs are written as if in here
end
```

This would provide all the facilities required of the toplevel without all the proxy troubles. Also, while I'm not so convinced of the merits of every toplevel method becoming a private method of all objects (and with Main that can be easily prevented), it has proven workable in practice so it's not a significant factor of consideration here. Main can simply be included in Object to achieve that effect.

```ruby
class Object
  include Main
end
```

But when we do that it becomes very clear what Main appears to be: Kernel. That strikes me as especially interesting. Then again, there may be good reasons to keep the Kernel as a separate module, in which case we'd just have a class hierarchy:

```ruby
Object.ancestors
=> [Object, Main, Kernel]
```

Nevertheless, it is clear the Kernel could just as well serve as the toplevel object, which, IMHO, makes this an elegant proposition to consider. Perhaps I'll start a campaign as November elections roll around: "Vote Kernel for Toplevel Object!" ;-)