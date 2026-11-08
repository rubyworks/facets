---
title: 'Main Campaign: Out of Object Now!'
date: 2006-08-21
published: false
---

The word from Matz on Kernel as toplevel object:

I don't feel that making Kernel as toplevel self is not a good idea,
because:

* toplevel def does not define methods on Kernel, but Object.
* toplevel include does not include modules into Kernel, but Object.
* toplevel private etc. do not work on Kernel, but Object.

I wouldn't call that an explanation exactly, more an explicative of the current behavior. I'm sure Matz has his reasons, and we can just assume that he wants to keep the namespace distinct. Fair enough, and of course he can do that. (It's not REALLY a democracy after all!) So Kernel drops out of the race. But the Kernel's running mate, Main, is still here campaigning.

You might be surprised to learn (as I was when I first discovered it):

```ruby
Object.public_instance_methods(false) +
Object.private_instance_methods(false) +
Object.protected_instance_methods(false)
=> []
```

That's right. There's not a single method defined in Object. All the methods ri tells you belong to Object actually are inherited from Kernel. But from there, any toplevel method we define does end-up in Object. Hence the clear separation of namespace I mentioned above.

Now a separate module, eg. Main, would do just as well. Kernel need not be used. And as I've expressed before, Main could be induced into Object for all the same effects. The base hierarchy then being Object < Main < Kernel.

But wait a second! Why are all these toplevel methods sneaking into all my Object's anyway? I can just as easily add them to Object myself if that's what I want. I don't need some cheap toplevel proxy to do it for me. In fact, that can be a problem too.

```ruby
module Foo
  def self.method_missing( name, *args )
    super unless require "foo/#{name}" rescue nil
    send( name,*args )
  end
end
```

Then some unsuspecting nuby comes along (okay I admit, it was I and it happened to me today!) and innocently adds to the top level:

```ruby
def check( name )
  name == "foo"
end
```

Well, so much for my lazily required Foo.check routine. It's been whacked from the top down!

You see where I'm going now? Primaries are over Main has taken Kernel out of the running with a new divisive platform. "Out of Object Now!"
