---
title: Ruby's Exceptional Exception Constructor
date: 2012-01-19
published: false
---

You would think after all this time Ruby's Exception class would be a rather robust and clearly comprehensible class.

```ruby
raise(exception [, string [, array]])
```

Now lets try something 

```ruby
class MyError < Exception
  def initialize()
    super()
  end
end
```

```ruby
>> raise MyError
MyError: MyError
	from (irb):12
	from /home/trans/.rbenv/versions/1.9.3-rc1/bin/irb:12:in `<main>'
```

No problem. But now lets try to set the message and the backtrace.

```ruby
>> raise MyError, "This is an error!"
ArgumentError: wrong number of arguments (1 for 0)
	from (irb):8:in `initialize'
	from (irb):13:in `exception'
	from (irb):13:in `raise'
```

Clearly Ruby expects any Exception's initialize method to handle the message argument. That's a rather strict contract for something Ruby is letting us override. But okay, let's take that as a given. Obviously Ruby is routing the #raise call to the exception's initializer. So then we should that the third `array` argument would passed along too. Turns out that's not the case.

```ruby
class MyError < Exception
  def initialize(*args)
    p args
    super(*args)
  end
end
```

```ruby
>> raise MyError, "This is an error!", caller
["This is an error!"]
RuntimeError: This is an Error!
	from (irb):1
	from /home/trans/.rbenv/versions/1.9.3-rc1/bin/irb:12:in `<main>'
```

Nope. No caller in sight. So where did it go? Turns out Ruby is setting the caller via the error's `#set_backtrace` method and doesn't depend on the initializer to handle it at all. This seems rather odd, since it was keen on letting the initializer handle the message argument, and would blow-up if the class won't take it.

So the upshot seems to be that we can't customize an exceptions initializer adn expect `#raise` to play along.

I actually had another point to make about how things gets even worse. Unfortunately had to take care of other chores and by the time I got back to this blog post (months later) I forgot what these "worse things" were. I think it had something to do with how `#message` calls `#to_s` rather then returning the message passed to the initializer. But as said I am not certain now. 

My conclusion however is this. I was attempting to make use of an Exception class as something more than a mere container for a string message for the [Assay](http://github.com/rubyworks/assay) project. That is when I ran into these oddities which made doing so quite unpleasant. To my dismay I ended up abandoning the approach. I brought some aspects of this up in a [issue report](http://bugs.ruby-lang.org/issues/5898).

For reference, here is the relevant Ruby [source code](https://github.com/ruby/ruby/blob/trunk/eval.c).