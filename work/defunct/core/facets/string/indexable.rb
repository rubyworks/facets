require 'facets/string/splice'
require 'facets/string/scan'
require 'facets/indexable'

class String

  include Indexable

  # An extraneous feature, but make String more ploymorphic
  # with Array.
  #
  #   "HELLO".at(2)  #=> "L"

  def at(index)
    case index
    when Fixnum
      self[index].chr
    else
      self[index]
    end
  end

  #Or should this be like #split? or self + '/' + other?
  #alias /      []

  #-----------------------------------------------------------------
  # The following methods override Indexable to better suit String.
  #-----------------------------------------------------------------

  # Returns the first separation of a string.
  # Default seperation is by character.
  #
  #   "Hello World".first       #=> "H"
  #   "Hello World".first(' ')  #=> "Hello"
  #

  def first(pattern=//)
    case pattern
    when Regexp, String
      split(pattern).at(0)
    else
      super
    end
  end

  # Returns the last separation of a string.
  # Default separation is by character.
  #
  #   "Hello World".last(' ')  #=> "World"
  #

  def last(pattern=//)
    case pattern
    when Regexp, String
      split(pattern).at(-1)
    else
      super
    end
  end

  # Removes the first separation from a string.
  # Defualt separation is by characters.
  #--
  # If a zero-length record separator is supplied,
  # the string is split on /\n+/. If the record
  # separator is set to <tt>nil</tt>, then the
  # string is split on characters.
  #++
  #
  #   a = "Hello World"
  #   a.first!       #=> "H"
  #   a              #=> "ello World"
  #
  #   a = "Hello World"
  #   a.first!(' ')  #=> "Hello"
  #   a              #=> "World"
  #

  def first!(pattern=//)
    case pattern
    when Regexp, String
      a = shatter(pattern) # req. scan
      r = a.first
      a.shift
      a.shift
      replace( a.join('') )
      return r
    else
      super
    end
  end

  # Removes the last separation from a string.
  # Default seperation is by characeter.
  #--
  # If a zero-length record separator is supplied,
  # the string is split on /\n+/. If the record
  # separator is set to <tt>nil</tt>, then the
  # string is split on characters.
  #++
  #
  #   a = "Hello World"
  #   a.last!       #=> "d"
  #   a             #=> "Hello Worl"
  #
  #   a = "Hello World"
  #   a.last!(' ')  #=> "World"
  #   a             #=> "Hello"
  #

  def last!(pattern=//)
    case pattern
    when Regexp, String
      a = shatter(pattern) #req. scan
      r = a.last
      a.pop
      a.pop
      replace(a.join(''))
      return r
    else
      super
    end
  end

  # TODO: Should Strin#first= replace first char as in Indexable?

  # Prepends to a string.
  #
  #   "Hello World".first = "Hello,"  #=> "Hello, Hello World"

  def first=(x)
    insert(0, x.to_s)
  end

  # Appends to a string.
  #
  #   "Hello World".last = ", Bye."  #=>  "Hello World, Bye."
  #

  def last=(str)
    self << str
  end

end
