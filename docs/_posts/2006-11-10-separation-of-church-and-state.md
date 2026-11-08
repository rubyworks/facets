---
title: Separation of Church and State
date: 2006-11-10
---

> **Update, November 2026:** Nothing relevant has changed since this was
> written: Ruby never adopted `obj.@ivar` or `def @ivar`, and both are still
> syntax errors.

Have you ever had a class so choke full of interrelated data and function members that you had trouble avoiding name clashes between the two. Of course it's a rare problem when you're in full control of the members, but when you're designing extensible classes, it becomes a major issue and you have to resort to some less-than-lovely work around.

Let me give you a simple scenario.

```ruby
class Package
  # Release date
  #
  attr :release

  # Release the package.
  #
  def release
     puts "Telling the world on #{@release}..."
     # ...
  end
end
```

The issue here is clear. On one hand, we want to use release as a noun to represent the date of release. On the other, we want to use it as a verb for releasing the package to the world. Of course, under completely isolated circumstances we could just change one of the names and deal. But when we are working on the basis of extensibility, where these and additional data or functional members may be added readily, say via a plug-in system, then a solution is not as simple.

So what can we do? The bottom line is that in some way or another the two member types must be distinguished from one another.

One could transform one set of the members with a slightly different name via some uniform convention. For instance, all data members could start with "my_", so release as a date would be my_release. Ruby actually makes this a bit nicer in that we can use '?' or '!' appended to method names. A fair solution might then be:

```ruby
def release?
  @release
end
```

or

```ruby
def release!
  puts "Telling the world on #{release?}..."
  #...
end
```

It's not a perfect solution however, especially as a matter of convention. It goes against the grain. '?' typically indicates a true/false query. And '!' indicates in place or caution. Consider how others will "smell" your code when they see a question mark for every reference to a data member.

The other more traditional solution is to use delegation. In this case we make a subclass for either or both of the member types. For instance:

```ruby
class Package

  class Data
    attr :release
  end

  attr :data

  def initialize
    @data = Data.new
  end

  def release
    puts "Telling to the world on #{data.release}..."
    #...
  end

end
```

Albeit a bit longer. It works very well. Delegation is a powerful tool. One could even emulate the former solution via method_missing, trapping method calls that end in '?' and rerouting them to @data. Another advantage is that we can readily pass around the data independent of the function members. On the flip side however, we are relegated to this special data.member interface. And likewise any reverse access by the data members to the functional members, if ever needed, would require us to also pass a reference to the Package instance into the Data instance.

In considering all this of course, it becomes apparent that Ruby already has a means of distinguishing data members from functional members via instance variables. Clearly @release references the date. But Ruby does not give us the power to treat "instance members" publicly or programmatically. We can't, for instance, use project.@release to access the release date. Nor can we wrap data members in order to massage their data, say:

```ruby
def @release
  super || Time.now
end
public :@release
```

I'm sure many readers will take such notion for simply god awful. But I think careful consideration at least warrants the fair question. "Is a distinct separation between data and functional members useful?" The mere existence of instance variables indicates that the distinction is in fact useful. In contrast, data members could have been made indistinguishable from functional members, or local variable persistence could be used in their stead. So if the distinction is useful, why hide public access to data members behind functional members acting as mini-delegates?

To be a bit more pragmatic, how would a solution to our example pan out if data members were in fact accessible? Interestingly it could look exactly like the original example. Public access to the release date however would simply come via project.@release or preferably even project@release. And there would be no need for any name (mis)conventions or special-interface delegation.

Of course let's be honest here. '@' itself is the Special Delegate of State to the Ruby "Church". Too bad he's only allowed to preach to the choir.
