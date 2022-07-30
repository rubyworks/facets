class Array
  # Returns an array of _indexes_ of all objects in receiver such that the object is == to obj.
  #
  # If a block is given instead of an argument, returns the _indexes_ of all objects for which the
  # block returns true.
  #
  # If neither a block nor argument is given, an Enumerator for _all_ indexes (each_index) is returned.
  #
  # Returns [] if no match is found.
  #
  #  a = [ "a", "b", "c" ]
  #  a.indexes("b").to_a              #=> [1]
  #  a.indexes("z").to_a              #=> []
  #  a.indexes { |x| x == "b" }.to_a  #=> [1]
  #
  # Like Array#index/rindex and Enumerable#find_index but returns _all_ indexes instead of just the
  # first/last.
  #
  # See also: proposal to add Array#indexes to Ruby language: https://bugs.ruby-lang.org/issues/6596
  #
  # @author Tyler Rick
  def indexes(*args)
    case args.length
    when 0
      if block_given?
        each_index.select {|i| yield(self[i]) }
      else
        each_index
      end
    when 1
      other = args.first
      each_index.select {|i| self[i] == other }
    else
      raise ArgumentError, "wrong number of arguments (given #{args.length}, expected 0..1)"
    end
  end
  alias_method :index_all, :indexes
end

module Enumerable
  # Returns an enumerator of _indexes_ of all objects in receiver such that the object is == to obj.
  #
  # If a block is given instead of an argument, returns the _indexes_ of all objects for which the
  # block returns true.
  #
  # If neither a block nor argument is given, an Enumerator for _all_ indexes is returned.
  #
  # Returns [] if no match is found.
  #
  #  a = ("a".."c")
  #  a.indexes("b").to_a              #=> [1]
  #  a.indexes("z").to_a              #=> []
  #  a.indexes { |x| x == "b" }.to_a  #=> [1]
  #
  # Like Array#index/rindex and Enumerable#find_index but returns _all_ indexes instead of just the
  # first/last.
  #
  # See also: proposal to add Array#indexes to Ruby language: https://bugs.ruby-lang.org/issues/6596
  #
  # @author Tyler Rick
  #
  def indexes(*args)
    # Enumerable doesn't have each_index like Array has, so this uses each_with_index instead.
    case args.length
    when 0
      if block_given?
        each_with_index.select {|el, i| yield(el)     }.map {|el, i| i }
      else
        each_with_index.                                map {|el, i| i }.to_enum
      end
    when 1
      other = args.first
      each_with_index.  select {|el, i| el == other   }.map {|el, i| i }
    else
      raise ArgumentError, "wrong number of arguments (given #{args.length}, expected 0..1)"
    end
  end
  alias_method :index_all, :indexes
end

class Enumerator::Lazy
  # Returns an enumerator of _indexes_ of all object in receiver such that the object is == to obj.
  #
  # If a block is given instead of an argument, returns the _indexes_ of all objects for which the
  # block returns true.
  #
  # If neither a block nor argument is given, an Enumerator for _all_ indexes is returned.
  #
  #   enum = (42 .. Float::INFINITY).lazy.indexes
  #   #=> #<Enumerator::Lazy: ...>
  #   enum.next #=> 0
  #   enum.next #=> 1
  #   enum.first(5)  #=> [0, 1, 2, 3, 4]
  #
  # @author Tyler Rick
  #
  def indexes(*args)
    case args.length
    when 0
      if block_given?
        each_with_index.lazy.select {|el, i| yield(el)   }.map {|el, i| i }
      else
        each_with_index.lazy.                              map {|el, i| i }.to_enum
      end
    when 1
      other = args.first
      each_with_index.lazy.  select {|el, i| el == other }.map {|el, i| i }
    else
      raise ArgumentError, "wrong number of arguments (given #{args.length}, expected 0..1)"
    end
  end
  alias_method :index_all, :indexes
end
