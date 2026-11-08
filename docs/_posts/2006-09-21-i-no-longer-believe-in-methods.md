---
title: I No Longer Believe in Methods
date: 2006-09-21
published: false
---

Yes, that's right. I no longer believe in methods. Why? Becuase this is OOP and if the methods aren't honest to goodness objects from the start, without exception, then they are not really methods. They're just glorified functions.

Let me show you what I mean. I have a Project class in which is defined a set of tools that can manipulate it. Clearly the proper implementation abstraction for these tools is the method.

```ruby
Class Project
  def announce
    puts "This is my new project!"
  end
end
```

But these tools must be distinguishable from other supporting methods. Moreover additional information may be associated with these tools, like help information or valid states of the Project for the tool to be useful. How do we encode this information with Ruby? Since methods aren't first class objects, we are forced to return to functional programming. In which case, it is best to define some sort of DSL.

```ruby
module ProjectDSL
  def help( name, text )
    @help ||= {}
    @help[name] = text
  end

  def valid( name, &test )
    @valid ||= {}
    @valid[name] = test
  end
end

Class Project
  extend ProjectDSL

  def announce
    puts "This is my new project!"
  end

  help :announce, "Announces your project to the world!"
  valid :announce { @version > "0.0.0" }
end
```

Now this kind of thing has come up enough in large projects, such as Nitro, that a general means of annotation proved to be most effective.

```ruby
require 'facet/annotation'

Class Project
  def announce
    puts "This is my new project!"
  end

  ann :announce, :help => "Announces your project to the world!",
                 :valid => lambda { @version > "0.0.0" }
end
```

Annotations works very well, and if you find yourself in need of this kind of "method metadata" it is an excellent approach.

But I've worked with all this long enough now to be able to have a wide perspective on it and it's become very clear to me that the whole "special needs" arises out of the fact that Ruby is still just a functional language in this respect, and not a full OOPL. (And please no objections that method() and instance_method() make it otherwise, these do not provide a persitant object, but return a new object every time they are invoked.) So what might the above look like if it were not so? There would of course be more than one way to go about it, but imagine this:

```ruby
class Tool < Method
  attr_accessor :help

  def valid( &test )
    @valid = test
  end
end

Class Project
  def announce => Tool
    puts "This is my new project!"
  end

  announce.help = "Announces your project to the world!"

  announce.valid { @version > "0.0.0" }
end
```

I'm taking some liberties with the syntax here for clarity. But in anycase it certainly paints a provocative idea. And I would argue that it paints the approprite OOP idea too.