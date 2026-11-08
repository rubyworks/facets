---
title: "Ruby ♥ Higher-Order Functions"
date: 2011-09-07
---

> **Update, November 2026:** Facets still has `Functor`, and both examples still run. Ruby hasn't added anything like the functor method proposed below.

Ruby Facets has a class called [Functor](https://rubyworks.github.io/rubyfaux/?doc=https://rubyworks.github.io/facets/docs/facets-2.9.3/core.json#api-class-Functor). In common computer science parlance "functor" simply means an objectified function. Ruby already has more than its share of these with Method, Proc and blocks. So what does Functor bring to the table? It's a bit more than just a first-class function. Rather, it is a <i>higher-order function</i>. What it allows us to do is define a function that responds dynamically to a message call. Here is a very basic example to clarify the idea.

```ruby
require 'facets/functor'

f = Functor.new do |op, a|
  a.__send__(op, a)
end

f + 3   #=> 6
f * 3   #=> 9
f ** 3  #=> 27
```

So how are higher-order functions useful? There are many possibilities. Consider this crazy little core extension that just occurred to me this evening.

```ruby
require 'facets/functor'

class String
  def in_case(meth)
    Functor.new do |op, a|
      if op == :=== 
        a.__send__(meth, self)
      else
        nil
      end
    end
  end
end

case 'foo'
when 'f'.in_case(:start_with?)
  puts "Hey it starts with an `f`!"
end
```

And that's just off the top of my head. There are many potential uses. In fact, Ruby has a quite popular functor already known as *Enumerator*. But that is a very specialized implementation. What Functor does is make it easy for us to quickly roll our own generic higher-order functions.

Now you can read plenty of interesting articles about the merits of high-order functions. I'll even provide you a few links (see below). But what I really want to talk about in this article is the merits of Ruby making higher-order functions an integral part of the core language. Even as the current implementation of Functor stands, I think it would make a good addition to the language. But there is a downside to the implementation in that it must create a new object every time it is used. Using a cache can help, but that raises issues of memory footprint and serialization.

If, on the other hand, Ruby could internalize the concept of a Functor as a fluent method dispatch mechanism, Ruby would be able to remove this overhead. That is to say, if a higher-order function could be defined as a method, albeit a special kind of method, instead of as an object, then the overhead would be removed. Indulge my use of some pseudo-code similar to rescue notation in order to provide you an idea of what our previous example could look like:

```ruby
class String
  def in_case(meth) => op, a
    if op == :=== 
      a.__send__(meth, self)
    else
      nil
    end
  end
end
```

The exact notation is, of course, not the important thing. The point is that it's just a special kind of method that Ruby attaches to the class or module, and handles the dispatching mechanics internally without the need for instantiating a new hollow Functor object each time.

I think this would be a very cool feature. One of those things that would set Ruby even further apart from other languages.

**UPDATE**: I recently learned that Python handles higher-order functions in an interesting way:

```python
def f(n):
    def g(x):
        return x + n
    return g
```

Ruby doesn't have first-class methods, so emulating Python's behaviour here would require a slightly different approach, probably something like:

```ruby
def f(n)
  g = lambda do |x|
    return x + n
  end
  dispatch g
end
```

Where `dispatch` would be a new keyword akin to `return`. Yet such an approach still suffers from the creation of a spurious object, albeit in this case it is a temporary local lambda that probably can be GC'd pretty quickly. So this is a middle ground possibility. Personally, I still think the previously mentioned special method idea is better. And we want Ruby to be better than Python, right? ;)

Links:

* <http://c2.com/cgi/wiki?HigherOrderFunction>
* <https://web.archive.org/web/20120711143310/http://kbullock.ringworld.org/2007/03/26/higher-order-messaging/>

<!--
categories: [functor, higher-order functions]
-->
