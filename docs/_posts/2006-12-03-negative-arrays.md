---
title: Negative Arrays
date: 2006-12-03
published: false
---

My current work involves the creation of an extensive configuration file format representing project information. In a number of cases I have had need of an inclusion list, representing files and file patterns to include for some operation --say, what files to include in a package. In such a case I generally end up with a least two parameters which I basically label include and exclude. While include is the list of files to use, exclude is list of files to exclude from the included list. Using exclude makes it easier to specify a large selection and then subsequently omit a file or two. The include list typically has a suitable default value, so a third parameter is sometimes also of use, append, which concats to the defaults as opposed to replacing the include parameter outright.

Since these three parameters help define what is essentially one list of data, it would be nice if they could be specified as a single parameter too. So I gave the problem some thought.

Taking inspiration from the notion of a negated symbol (see facets/symbol/not). It occurred to me that any object that can be added or subtracted is taking part in the same "algebraic group" as whole numbers. And just as a whole number can be negative, why not also an array?

```ruby
a =  [:a,:b,:c,:d,:e]
n = -[:d,:e]
a + n #=> [:a,:b,:c]
```

So this could be very helpful. And it shouldn't be too much hard to implement.

```ruby
class Array
  def @-
    @negative = !@negative
    self
  end

  def negative?
    @negative
  end

  alias :add :+
  alias :sub :-

  def +(other)
    if negative?
      if other.negative?
        -add(other)
      else
        -sub(other)
      end
    else
      if other.negative?
        sub(other)
      else
        add(other)
      end
    end
  end

  ...
end
```

I'm sure tighter implementation is possible, but you get the idea. So then include and exclude parameters could be specified in a single parameter.

```ruby
files = [ '**/*', -[ 'Installedfiles' ] ]
```

Neat! But unfortunately it doesn't really solve the whole problem since YAML doesn't understand this negative listing concept either. It could still be of use in general Ruby scripts though. Notations such as this often prove very powerful. And in fact the idea does move us in a possible workable direction. There's no reason a string can't be marked as negative as well. After all it's just a flag. In fact, if we move the core method @- to Object itself, then any object can be so indicated. The above line could then be written:

```ruby
files = [ '**/*', -'Installedfiles' ]
```

Methods such as Dir.multiglob(*files) (another Facet) could use this extra bit of information to provide the desired results, equivalent to:

```ruby
files = Dir.glob('**/*') - Dir.glob('InstalledFiles')
```

Of course, this still doesn't quite help us with the YAML configuration file, but with a little fudging we can get a useful format.

```ruby
files: [ '**/*', '-InstalledFiles' ]
```

As for the append parameter that was mentioned as the beginning, we could just add a special notation for this as well, say, '$' to mean defaults.

Okay. So will I use this bit of trickery to reduce three parameters to one? Perhaps. While the result is wonderfully practical in usage, it's not necessarily so simple to implement. Either a filter would have to split the one entry into three parts when loading, or an untold number of methods would have to augmented to take the trick into consideration. The later I imagine would simply prove too extensive w/o pre-established support for the negation concept. The former might be reasonable however. I'll give it a try.

In any case it was in interesting thought experiment. Although perhaps you have a better way to represent this kind of information?
