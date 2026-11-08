---
title: What Concerns
date: 2013-01-01
---

> **Update, November 2026:** Nothing in Ruby has changed that bears on
> this: including a module still doesn't bring along its singleton methods,
> and modules still can't inherit from one another, which I proposed in
> [The Case for Module Inheritance]({{ site.baseurl }}{% post_url 2010-04-13-a-case-for-module-inheritance %}).

David Heinemeier Hansson, the well known creator of Rails, recently gave a little [pep-talk](http://37signals.com/svn/posts/3372-put-chubby-models-on-a-diet-with-concerns) for the use of `ActiveSupport::Concern`, making an argument that they were sufficient to satisfy the practical needs of [DCI](http://en.wikipedia.org/wiki/Data,_context_and_interaction)'s theory.

What he fails to explain is what Concerns *really are*. Truth be told, Concerns are essentially an extension of Ruby's `Module` class to more fully support *multiple inheritance*. Whether out of indifference, simple oversight or perhaps a bit of decorum to save Matz's sensitivities, who has a well known distaste for multiple inheritance, DHH never mentions this simple fact. Concerns are a way for Rails developers to include Modules with the same degree of functionality as inheriting from a superclass.

To say that Concerns are like DCI Roles, is akin to saying C structs are like OOP Objects. Yea, there's a similarity there, but it's vastly missing the point.
