---
title: Proper Construction of a Class
date: 2012-05-09
published: false
---

> **Update, November 2026:** Nothing here has changed: Ruby's Hash is still written in C, and methods such as `#update` and `#each` still work on the hash table directly rather than through `#store` and `#fetch`.

# The Proper Construction of a Class [DRAFT]

A general principle of good programming is SOC, Separation of Concerns. SOC
is a general rule that helps us break code up into logical groups around a single concern.
More often the principle is applied at a systems level via separate packages, tools, libraries
or components. But the principle is equally applicable to a class itself.

Ruby's own Hash class provides a good example to demonstrate how this principle can be applied.
When we consider the concerns of the Hash class we must think of the methods that make it a Hash.
The most fundamental distinction between methods for any class is the fundamental methods versus
the derivative methods. In other words, derivative methods depend on the fundamental methods, and
have no direct contact to the underlying state of the object except via the fundamental methods.
This division not only gives us guidance on how to organize our classes, but also how to best
write methods for our classes --by attempting to use the minimum number of necessary fundamental
methods.

For Ruby's Hash, the fundamental methods are more or less `#fetch`, `#store`, `#delete`, `#keys`, `#key?` and perhaps `#size` in addition to any necessary equality methods, such as `#==`. There are, of course, Ruby system methods also, such as `#hash` and `#inspect`, but we can take them for granted. All other methods, such as `#update` and `#each` can be built from these methods.

Of course Ruby's Hash isn't actually implemented in this way. But it **should** be! This kind of design I call "CRUDified", because the fundamental methods of any class are generally the ones that represent create, read, update and delete functions.

Who would have ever thought this was good advice? "Make your models CRUDy!" :-)
