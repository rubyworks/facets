---
title: Autoload Smells like Denmark
date: 2012-06-14
published: false
---

Ruby has a very cool feature called *autoload*. With autoload, any undefined constant can automatically trigger the loading of a library file. Effectively this gives Ruby a convenient means of lazy loading. For example, lets say some of our app's executable scripts ultimately use the ANSI library, but others do not. We can use `autoload` to only load the ANSI library when it is needed.

```ruby
autoload ANSI, 'ansi'
```

This says to `require "ansi"` the first time an undefined ANSI constant is encountered.

As wonderful as autoload seems, it has too glaring issues: 1) It doesn't use standard Kernel#require and 2) It is not thread safe. 

For the first, this means that any overriding of #require will not be supported by autoload. Of course such a thing is very rare, but it does occur. For instance the [Roll](https://rubygems.org/gems/roll) library is all about overriding `#require`. Also RubyGems overrides #require, and in fact one can cause a bug to occur when using autoload because of it. Here's a very simple [example](http://stackoverflow.com/questions/849622/autoload-raises-an-error-but-require-does-not-ruby).

On the second case the issue seems much more complicated, and a solution seems so unlikely that Matz has called for #autoload to be [removed](http://bugs.ruby-lang.org/issues/5653) from Ruby by v3.0.0. That's a long way off but just the same it doesn't bode well for autoload. 

Now that Matz has effectively declared `#autoload` a code smell, I wonder if developers will take heed and stop using it? I have my doubts --it's just too damn convenient. I just wish it would use `Kernel#require` so I could use it along with Rolls.


