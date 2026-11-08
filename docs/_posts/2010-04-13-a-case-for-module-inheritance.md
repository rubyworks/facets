---
title: The Case for Module Inheritance
date: 2010-04-13
---

> **Update, November 2026:** Ruby 3.0 fixed the Double Inclusion Problem
> ([#9573](https://bugs.ruby-lang.org/issues/9573)): when a module includes
> another module, any class or object that already included or extended the
> first one now gets the new one too, so components can be loaded as needed.
> Module inheritance never came, though. `module English < Language` is
> still a syntax error, and singleton methods still aren't inherited through
> `include`, so the `self.included`/`ClassMethods` idiom is still needed for
> that.

I love beautifully written code. Unfortunately the realities of the
language sometimes clash with requirements of the implementation. While
Ruby goes a long way toward making beautifully written code common place.
It still has some shortcomings I'd like to see improved.

Case in point are my endeavors of the last few days. I've been struggling
to re-structure the code of the <a href="http://github.com/rubyworks/english/">English</a>
project. The primary purpose of the project is to provide extension methods to String,
pertaining to the English language. A good example are number inflection
methods #singular and #plural. At the same time I am trying to design
the library in such a way that other language modules can be built following
the same basic structure, and they could all work together if need be.

In the course of this endeavor I decided the best approach, keeping the future
squarely in mind, is to create a Language module, upon which English depends,
to house all the common logic of (most) languages. For example, the logic for
storing plural and singular special cases might be a good candidate since nearly
every language has to account for these. So the relationship between English 
and Language is clearly one of "inheritance" --I want to encapsulate logic at
a general level of abstraction, upon which more specific cases can inherit and
augment to fit their particular requirements.

In Ruby this kind of relationship is generally handled by class inheritance.
But here I run into an issue. <code>English</code> and <code>Language</code>
are modules, and they are modules because they are <i>singleton</i>. Now even
though we can include a module into another, which is akin to class inheritance,
it does not work quite like class inheritance. For one thing, metaclass methods
are not inherited via <code>include</code>. Of course, I could tip-toe around
this issue by using <code>extend</code>, since in this case I do not need
includable instance methods. But there is a much more subtle issues that
raises it's head: the dreaded Double Inclusion Problem. That's a serious
headache in my case because I want my end users to have the option to load
only the components they want to use as needed, rather than forcing them to
load the entire system up-front.

So, despite the many
<a href="http://www.google.com/search?q=singleton+pattern+evil">calls for the death
of the Singleton Pattern</a>, it looks like I might require it for my implementation
of English. Using modules simply comes with too many headaches and hackish work arounds.
Now I agree with all the Singleton nay-sayers. It is sort of an anti-pattern to 
create a class that will only ever have one instantiation and no state, but
the trade-off here is worse. If only...

It seems to me the truly fantastic solution to this would be if one module
could inherit from another just as we do with classes. And honestly, is there
really any reason we shouldn't be able to do this?

    module Language

      def self.words(string)
        # generic definition
      end

    end

    module English < Language

      def self.words(string)
        # override
      end

    end

What is nice about this, something I know that Matz will appreciate, is that
it preserves single-inheritance, in contrast to the alternative of
turning <code>include</code> into a multiple-inheritance mechanism. And
for the love of code beauty, it would mean at least a reduction in use of the
all too common: 

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      # ...
    end

Not only is it ugly, it is even worse for those trying to inherit and
extend the behavior. Something more elegant is clearly desirable, and
Module Inheritance, as I have demonstrated here, might be just the ticket.

<!--
title      : A Case for Module Inheritance
author     : trans
categories : [ruby]
date       : 2010-04-13
layout     : post
-->
