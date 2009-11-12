---
title: 'I Spy String#margin'
author: Trans
tags: 
- Tutorial
layout: post
---

Perhaps you've come across that occasional need to assign a string that was more pictorial
in character than textual. [ Pun intended :-) ] You've tried Ruby's various built-in string constructors,
including those groovy HERE documents, you even tried letting the HERE text butt up against column
zero. Ick! In the end you either had line after line of <code>str &lt;&lt; "...."</code>, counted "\n"s
or said, "Heck wit it!". And loaded from a file. Well, no longer! Facets contains a great little
String method called #margin. It works like this:</p>

{% highlight ruby %}
  x = %Q{
        | This
        |     is
        |       margin controlled!
        }.margin
{% endhighlight %}

Of course you can  use HERE documents if you prefer.

{% highlight ruby %}
  x = <<-HERE.margin
        | This
        |     is
        |       margin controlled!
        HERE
{% endhighlight %}

If you dislike the particular deliminator '|', or actually need to start lines with that character,
then just pick another.

{% highlight ruby %}
  x = %Q{ This
        -     is
        -       margin controlled too!
        }.margin
{% endhighlight %}

The trick? It uses the first non-whitespace character on the 2nd line(tm). Clever, eh?

But wait. There's more! #margin also takes a parameter, with which you can specify the number of
extra spaces to insert in place of the deliminator. So even if you need to push some ascii art
text over 30 characters, there's no need for all that whitespace. Just specify the number.</p>

Hope you've enjoyed this Spotlight. Now you too can produce nice and readable margin controlled
strings in your code too with ease!

