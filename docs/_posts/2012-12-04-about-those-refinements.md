---
title: About those Refinements
date: 2012-12-04
published: false
---

Well, after a ridiculously long discussion about refinements, it's finally become clear what Matz is up to. It would have helped if he had mentioned from the start that he's patterning them directly off of Smalltalk wrappers and CLOS method combinations. Instead we get [this](http://bugs.ruby-lang.org/projects/ruby-trunk/wiki/RefinementsSpec) "offical" spec. Hardly. It was only thanks to Charles Nutters careful [analysis](https://bugs.ruby-lang.org/issues/4085#note-217) that I was able to to get a clear picture. Oh, the time and data that could have been saved!

So allow me to save you all the trouble and explain refinements in very simple phrase: _macros des méthodes_. In plain English, they are macros that act on method invocations. For example,

```ruby
module M
  def self.string(object)
    string.to_s
  end
end

module Q
  refine String
    def to_s
      "Every string is #{super}!"
    end
  end
end

using Q

M.string("okay") #=> "okay"
```

Notice, the `M.string` method is not effected by the refinement of `String#to_s` even though it uses `#to_s` in its definition. However, if we use `#to_s` explicitly in the scope of the refinement's use we get:

```ruby
"okay".to_s #=> "Every string is okay!"
```

Even though that is exactly what the definition of `M.string` is, it produces the refined result instead. Since the call was explicit the refinement interceded.

That's really the crux of refinements. Most of the remaining questions pertain to the order in which multiple refinements interact, but it is all pretty much as one would intuit it to be, so we won't go into detail in that regard.

Now I thought it might be helpful to take an extreme example of what one could do with refinements and see if it leads us to anything interesting.

Let's take just a bare class.

```ruby
class Person
end
```

Now lets create two refinements defining two different roles a person might take.

```ruby
module Buyer
  refine Person do
    attr :stuff, :money
    def initialize(money, *stuff)
      @money = money.to_f
      @stuff = stuff
    end
    def buy(product, cost)
      @stuff.push product
      @money -= @money
    end
  end
end

module Seller
  refine Person do
    attr :stuff, :money
    def initialize(money, *stuff)
      @money = money.to_f
      @stuff = stuff
    end
    def sell(product, cost)
      @stuff.delete product
      @money += @money
    end
  end
end
```

Now let's define an activity in which persons interact as each of these roles.

```ruby
using Seller
using Buyer

class SalesTransaction
  def self.make(buyer, seller, product, cost)
    buyer.buy(product, cost)
    seller.sell(product, cost)
  end
end
```

Interesting? Person has no built-in behavior, and yet we've managed to use the class to model a sales transaction and give each person state of what they own and how much money they have. And an outside interface can't find this state out unless it knows what role to apply!

You might recognize the pattern of this example. It is [DCI](http://en.wikipedia.org/wiki/Data,_context_and_interaction). Does this mean refinements are a prefect fit for DCI-based designs? Might we see a whole new paradigm in Ruby architecture built around the DCI? That's a good question. At first glance it certainly seems to be possible. But we should note a obvious downsides.

1. Both refinements required an `#initialize` method to ensure the instance variables are initialized. So  refinements of this kind would have to be compatible in this respect in order to be used together.
2. The context, in this case `SalesTransaction`, has to exist in it's own file so only the appropriate refinements apply. There is no way to define contexts that use different refinements in the same file because refinements are applied on a per-file basis. Although, some level of cleverness could be played if certain contexts simply add additional refinements on top of those used earlier in the file.
3. While it remains to be seen, it is unlikely that an entire system written in this fashion will be very fast. Nor is entirely certain the it would very comprehensible, but perhaps that has more to do with DCI then refinements.


