--- 
title: 'I Spy Integer#times_collect'
author: Trans
tags: 
- Tutorial
layout: post
---

The method #collect, or its alias #map if your prefer, is one of the most useful methods
in Rubyland. You see it all the time. Unfortunately it isn't applicable to a number of common
variants of iteration. One of these is Integer#times. So Facets provided just such a method.</p>

{% highlight ruby %}
  require 'facets/integer/times_collect'

  bottles = 99.times_collect { |i|
    "Bottle of Beer No. #{i}"
  }
{% endhighlight %}

This is also aliased as <code>times_map</code>. But if either of these method names strikes you
as too long then you might find this alternate (required separately) more convenient:</p>

{% highlight ruby %}
  require 'facets/integer/of'

  bottles = 99.of { |i|
    "Bottle of Beer No. #{i}"
  }
{% endhighlight %}

Take one down, pass it around!

