module Enumerable
  # This is a simple reimplementation of the core Enumerable module
  # to allow its methods to take and pass-on arbitrary arguments to the
  # underlying #each call. This library uses Enumerator and scans
  # Enumerable so it can alwasy stay in sync.
  #
  # NOTE: Any Enumerable method with a negative arity cannot pass arguments
  # due to ambiguity in the argument count. So the methods #inject and #zip
  # do NOT work this way, but simply work as they do in Enumerable. However,
  # The methods #find and #detect have been made modified to work by removing
  # its rarely used optional parameter and providing instead an optional
  # keyword parameter (:ifnone => ...). Please keep these difference in mind.
  #
  # Example
  #   require 'enumargs'
  #
  #   class T
  #     include Enumerable::Argumentable
  #     def initialize(arr)
  #       @arr = arr
  #     end
  #     def each(n)
  #       arr.each{ |e| yield(e+n) }
  #     end
  #   end
  #
  #   t = T.new([1,2,3])
  #   t.collect(4)
  #   #=> [5,6,7]
  #
  module Argumentable

    # Helper method to wrap Enumerable methods.
    def self.wrap_enumerable_method( methodname )
      m = methodname
      meth = Enumerable.instance_method(m)
      arity = meth.arity

      case arity <=> 0
      when 0
        class_eval %{
          def #{m}( *args, &yld )
            enum_for(:each, *args).#{m}( &yld )
          end
        }
      when 1
        class_eval %{
          def #{m}( *args, &yld )
            args, each_args = args[0...#{arity}], args[#{arity}..-1]
            enum_for(:each, *each_args).#{m}( *args, &yld )
          end
        }
      else
        # this branch is used when the method has a variable number of arguments
        #   resulting in an arity of -1.  Right now this is bugged as it does
        #   not pass the argument to the each, and always passes the argument
        #   to the method.  This makes methods like .min amdn .max to act
        #   in an unexpected manner.
        class_eval %{
          def #{m}( *args, &yld )
            enum_for(:each).#{m}( *args, &yld )
          end
        }
      end
    end

    # Wrap all Enumerable's public instance methods
    Enumerable.instance_methods(false).each do |m|
      wrap_enumerable_method( m )
    end

    # Support for #to_a.
    #
    def to_a(*args)
      #map(*args){ |x| x }
      enum_for(:each, *args).to_a
    end

    # Make exception for #find (a negative arity method) to accept
    # keyword argument.
    #
    #   ObjectSpace.find(Class, :ifnone=>lambda{1}) { |e| ... }
    #   ObjectSpace.find(Class, :ifnone=>lambda{1}) { |e| ... }
    #
    def find(*args, &yld)  # future use **keys ?
      if Hash === args.last and args.last.key?(:ifnone)
        ifnone = args.last.delete(:ifnone)
        args.pop if args.last.empty?
        enum_for(:each, *args).find( ifnone, &yld )
      else
        enum_for(:each, *args).find( &yld )
      end
    end

    alias_method :detect, :find

  end

  # DEPRECATED: Module alias for old name.
  Arguments = Argumentable
end


=begin  OLD CODE
  module EnumerableArgs

    def collect(*args)  # :yield:
      a = []
      each(*args){ |n| a << yield(n) }
      a
    end
    alias_method( :map, :collect )

    def detect(*args)  # :yield:
      each(*args){ |n| return n if yield(n) }
      nil
    end
    alias_method( :find, :detect )

    def each_with_index(*args)
      i=0
      each(*args){ |*n| n << i; yield(*n); i+=1 }
      self
    end

    def to_a(*args)
      a = []
      each(*args){ |n| a << n }
      a
    end
    alias_method( :entries, :to_a )

    # An additional method not part of standard Enumerable.
    # The regular version of this method can be found in Facets,
    # but it is a bit more advanced then this one.
    # At some point they need to be put into sync.
    def each_slice(*args, &yld)
      a = []; s = []
      ar = yld.arity.abs
      each(*args){ |n|
        s << n
        if s.length >= ar
          yld.call(*s)
          s = []
        end
      }
      a
    end
    alias_method( :each_by, :each_slice )

    def select(*args)  # :yield:
      a = []
      each(*args){ |n| a << n if yield(n) }
      a
    end
    alias_method( :find_all, :select )

    def grep(pattern, *args)
      a = []
      each(*args){ |n| a << (block_given? ? yield(n) : n) if pattern === n }
      a
    end

    def include?(anObj, *args)
      each(*args){ |n| return true if anObj == n }
      false
    end
    alias_method( :member?, :include? )

    def max(*args)
      to_a(*args).max
    end

    def min(*args)
      to_a(*args).min
    end

    def reject(*args)
      a = []
      each(*args){ |n| a << n if ! yield(n) }
      a
    end

    def sort(*args)
      # TODO
    end

  end
=end

# Copyright (c) 2004 Rubyworks (BSD-2-Clause)
