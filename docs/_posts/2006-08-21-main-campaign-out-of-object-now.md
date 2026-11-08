---
title: 'Main Campaign: Out of Object Now!'
date: 2006-08-21
---

> **Update, November 2026:** The top level still works as matz describes,
> and `Object` still defines no methods of its own: run as a script on
> Ruby 3.4, the first example below still returns `[]`. The `Foo.check`
> example needs a qualification. A top-level method is a private method of
> `Object`, so a call with an explicit receiver, like `Foo.check("foo")`,
> goes to `Foo.method_missing`, and the lazy load works. The top-level
> `check` only gets in the way when it is called without a receiver from
> inside `Foo`, or through `send`, or in irb before Ruby 2.0, where
> top-level methods were public
> ([Bug #5776](https://bugs.ruby-lang.org/issues/5776)). irb now makes them
> private, as a script does. I took up the idea of Main again in
> [Kill the Proxy and Save Toplevel]({{ site.baseurl }}{% post_url 2012-06-17-kill-the-proxy-and-save-toplevel %}).

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

But wait a second! Why are all these toplevel methods sneaking into all my Objects anyway? I can just as easily add them to Object myself if that's what I want. I don't need some cheap toplevel proxy to do it for me. In fact, that can be a problem too.

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

You see where I'm going now? Primaries are over. Main has taken Kernel out of the running with a new divisive platform. "Out of Object Now!"
