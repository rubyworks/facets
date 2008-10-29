# TO BE DEPRECATED!!!
#
# Ruby 1.9 Compatability layer.
# This makes 1.8.x partially compatabile with 1.9.
#
# THIS IS NOT COMPLETE! Please help beef it up!
#
# Also it can not be 100% compatabile either b/c in some
# cases it is not possible (or too difficult) to do in pure Ruby.

unless (RUBY_VERSION[0,3] == '1.9')

  require 'facets/kernel/instance_exec'
  require 'enumerator'

  class Array

    # Provides the cross-product of two or more Enumerables.
    # This is the class-level method. The instance method
    # calls on this.
    #
    #   Enumerable.cartesian_product([1,2], [4], ["apple", "banana"])
    #   #=> [[1, 4, "apple"], [1, 4, "banana"], [2, 4, "apple"], [2, 4, "banana"]]
    #
    #   Enumerable.cartesian_product([1,2], [3,4])
    #   #=> [[1, 3], [1, 4], [2, 3], [2, 4]]
    #
    #   a = []
    #   [1,2].cart([4,5]){|elem| a << elem }
    #   a  #=> [[1, 4],[1, 5],[2, 4],[2, 5]]
    #
    #  CREDIT: Thomas Hafner

    def product(*enums, &block)
      enums.unshift self
      result = [[]]
      while [] != enums
        t, result = result, []
        b, *enums = enums
        t.each do |a|
          b.each do |n|
            result << a + [n]
          end
        end
      end
      if block_given?
        result.each{ |e| block.call(e) }
      else
        result
      end
    end

    # Yields the block to each unique combination of _n_ elements.
    #
    #   a = %w|a b c d|
    #   a.combination(3)
    #
    # produces
    #
    #   [["a", "b", "c"],
    #    ["a", "b", "d"],
    #    ["a", "c", "d"],
    #    ["b", "c", "d"]]
    #
    # CREDIT: Florian Gross

    def combination(k=2)
      if block_given?
        s = to_a
        n = s.size
        return unless (1..n) === k
        idx = (0...k).to_a
        loop do
          yield s.values_at(*idx)
          i = k - 1
          i -= 1 while idx[i] == n - k + i
          break if i < 0
          idx[i] += 1
          (i + 1 ... k).each {|j| idx[j] = idx[i] + j - i}
        end
      else
        to_enum(:combination, k)
      end
      #a = []
      #s = self
      #n = s.size
      #return unless (1..n) === k
      #dx = (0...k).to_a
      #loop do
      #  a << s.values_at(*idx)
      #  i = k - 1
      #  i -= 1 while idx[i] == n - k + i
      #  break if i < 0
      #  idx[i] += 1
      #  (i + 1 ... k).each {|j| idx[j] = idx[i] + j - i}
      #end
      #a
    end

    # Permutation provids the possible orders of an enumerable.
    # Each is indexed by a permutation number. The maximum number of
    # arrangements is the factorial of the size of the array.
    #
    #  CREDIT: Shin-ichiro Hara

    def permutation(n=size)
      if size < n or n < 0
      elsif n == 0
        yield([])
      else
        self[1..-1].permutation(n - 1) do |x|
          (0...n).each do |i|
            yield(x[0...i] + [first] + x[i..-1])
          end
        end
        self[1..-1].permutation(n) do |x|
          yield(x)
        end
      end
    end

  end

  class Binding

    # Evaluate a Ruby source code string (or block) in the binding context.

    def eval(str) #='', &blk )
      #if block_given?
      #  Kernel.eval( self, &blk )
      #elsif str
        Kernel.eval(str, self)
      #end
    end

  end

  module Enumerable

    # Count the number of items in an enumerable
    # equal (==) to the given object.
    #
    #   e = [ 'a', '1', 'a' ]
    #   e.count('1')    #=> 1
    #   e.count('a')    #=> 2
    #
    # Count can also handle multiple-valued blocks.
    #
    #   e = { 'a' => 2, 'a' => 2, 'b' => 1 }
    #   e.count('a',2)  #=> 1
    #
    #   CREDIT: Trans

    def count(*c)
      self.select{ |*i| i == c }.length
    end

    # Enumerable#one? returns +true+ if and only if <em>exactly one</em>
    # element in the collection satisfies the given predicate.
    #
    # If no predicate is provided, Enumerable#one? returns +true+ if
    # and only if <em>exactly one</em> element has a true value
    # (i.e. not +nil+ or +false+).
    #
    #   [].one?                      # false
    #   [nil].one?                   # false
    #   [5].one?                     # true
    #   [5,8,9].one?                 # false
    #   (1...10).one? { |n| n == 5 } # true
    #   (1...10).one? { |n| n < 5 }  # false
    #
    #   CREDIT: Gavin Sinclair

    def one?  # :yield: e
      matches = 0
      if block_given?
        self.each do |e|
          if yield(e)
            matches += 1
            return false if matches > 1
          end
        end
        return (matches == 1)
      else
        one? { |e| e }
      end
    end

    # Enumerable#none? is the logical opposite of the builtin method
    # Enumerable#any?.  It returns +true+ if and only if _none_ of
    # the elements in the collection satisfy the predicate.
    #
    # If no predicate is provided, Enumerable#none? returns +true+
    # if and only if _none_ of the elements have a true value
    # (i.e. not +nil+ or +false+).
    #
    #   [].none?                      # true
    #   [nil].none?                   # true
    #   [5,8,9].none?                 # false
    #   (1...10).none? { |n| n < 0 }  # true
    #   (1...10).none? { |n| n > 0 }  # false
    #
    #   CREDIT: Gavin Sinclair

    def none?  # :yield: e
      if block_given?
        not self.any? { |e| yield e }
      else
        not self.any?
      end
    end

    # #group_by is used to group items in a collection by something they
    # have in common.  The common factor is the key in the resulting hash, the
    # array of like elements is the value.
    #
    #   (1..5).group_by { |n| n % 3 }
    #        #=> { 0 => [3], 1 => [1, 4], 2 => [2,5] }
    #
    #   ["I had", 1, "dollar and", 50, "cents"].group_by { |e| e.class }
    #        #=> { String => ["I had","dollar and","cents"], Fixnum => [1,50] }
    #
    #  CREDIT: Erik Veenstra

    def group_by #:yield:
      #h = k = e = nil
      r = Hash.new
      each{ |e| (r[yield(e)] ||= []) << e }
      r
    end

  end

  class Integer

    # Returns true if this integer is odd, false otherwise.
    #
    #   2.odd?            #=> false
    #   3.odd?            #=> true
    #
    #   -99.odd?          # -> true
    #   -98.odd?          # -> false
    #
    #   CREDIT: Gavin Sinclair

    def odd?
      self % 2 == 1
    end

    # Returns true if this integer is even, false otherwise.
    #
    #   2.even?  #=> true
    #   3.even?  #=> false
    #
    #   CREDIT: Gavin Sinclair

    def even?
      self % 2 == 0
    end

  end

  module Kernel

    # The tap K-Combinator. This yields self -and- returns self.

    def tap(&b)
      if block_given?
        b.arity == 1 ? yield(self) : instance_eval(&b)
      end
      self
    end

    # This is just an odd consideration for #tap using Functor:
    #
    #   require 'facets/functor'
    #
    #   # Yield self -and- return self.
    #
    #   def tap(&b)
    #     if block_given?
    #       b.arity == 1 ? yield(self) : instance_eval(&b)
    #       self
    #     else
    #       Functor.new{ |op, *args| self.send(op, *args); self }
    #     end
    #   end

    # Retreive the current running method name.
    #
    #   def tester; __method__; end
    #   tester  #=> :tester
    #
    # Technically __callee__ should provided alias names,
    # where __method__ should not. But we'll have to
    # leave that distinction to Ruby 1.9+.

    def __method__
      /\`([^\']+)\'/.match(caller(1).first)[1].to_sym
    end

    # Retreive the current running method name.
    #
    #   def tester; __callee__; end
    #   tester  #=> :tester
    #
    # Technically __callee__ should provided alias names,
    # where as __method__ should not. But we'll have to
    # leave that distinction to Ruby 1.9+.

    def __callee__
      /\`([^\']+)\'/.match(caller(1).first)[1].to_sym
    end

    private :__callee__, :__method__

  end

  class NilClass

    # Allows <tt>nil</tt> to respond to #to_f.
    # Always returns <tt>0</tt>.
    #
    #   nil.to_f   #=> 0.0
    #
    #   CREDIT: Matz

    def to_f; 0.0; end

  end

  class String

    # Upacks string into bytes.
    #
    #

    def bytes
      self.unpack('C*')
    end

    # Returns an array of characters.
    #
    #   "abc".chars  #=> ["a","b","c"]

    def chars
      self.split(//)
    end

    # Returns an array of characters.
    #
    #   "abc\n123".lines  #=> ["abc","123"]

    def lines
      self.split(/\n/)
    end

    # Iterates through each character. This is a little faster than
    # using #chars b/c it does not create the intermediate array.
    #
    #    a = ''
    #   "HELLO".each_character{ |c| a << #{c.downcase} }
    #    a  #=> 'hello'

    def each_char  # :yield:
      size.times do |i|
        yield(self[i,1])
      end
    end

    # Does a string start with the given prefix.
    #
    #   "hello".starts_with?("he")    #=> true
    #   "hello".starts_with?("to")    #=> false
    #
    #  CREDIT: Lucas Carlson
    #  CREDIT: Blaine Cook

    def start_with?(prefix)
      self.index(prefix) == 0
    end

    # Does a string end with the given suffix?
    #
    #   "hello".ends_with?("lo")    #=> true
    #   "hello".ends_with?("to")    #=> false
    #
    #  CREDIT: Lucas Carlson
    #  CREDIT: Blaine Cook

    def end_with?(suffix)
      self.rindex(suffix) == size - suffix.size
    end

  end

  class Symbol

    # Turn a symbol into a proc calling the method to
    # which it refers.
    #
    #   up = :upcase.to_proc
    #   up.call("hello")  #=> HELLO
    #
    # More useful is the fact that this allows <tt>&</tt>
    # to be used to coerce Symbol into Proc.
    #
    #   %w{foo bar qux}.map(&:upcase)   #=> ["FOO","BAR","QUX"]
    #   [1, 2, 3].inject(&:+)           #=> 6
    #
    # And other conveniences such as:
    #
    #   %{john terry fiona}.map(&:capitalize)   # -> %{John Terry Fiona}
    #   sum = numbers.inject(&:+)
    #
    #   TODO: This will be deprecated as of Ruby 1.9, since it will become standard Ruby.
    #
    # CREDIT: Florian Gross (orignal)
    # CREDIT: Nobuhiro Imai (current)

    def to_proc
      Proc.new{|*args| args.shift.__send__(self, *args)}
    end

    # OLD DEFINITION
    #def to_proc
    #  proc { |obj, *args| obj.send(self, *args) }
    #end

    # Successor method for symobol. This simply converts
    # the symbol to a string uses String#succ and then
    # converts it back to a symbol.
    #
    #   :a.succ => :b
    #
    #  TODO: Make this  work more like a simple character dial?

    def succ
      self.to_s.succ.intern
    end

  end

  class Time

    # Convert a Time to a Date. Time is a superset of Date.
    # It is the year, month and day that are carried over.

    def to_date
      require 'date' # just in case
      jd = Date.__send__(:civil_to_jd, year, mon, mday, Date::ITALY)
      Date.new!(Date.__send__(:jd_to_ajd, jd, 0, 0), 0, Date::ITALY)
    end

    # To be able to keep Dates and Times interchangeable
    # on conversions.

    def to_time
      getlocal 
    end

  end

  class UnboundMethod

    # Return the name of the method.
    # Is this already in 1.9+ ?
    #
    #   class X
    #     def foo; end
    #   end
    #
    #   meth = X.instance_method(:foo)
    #
    #   meth.name  #=> "foo"
    #
    #   CREDIT: Trans

    def name
      i = to_s.rindex('#')
      to_s.slice(i+1...-1)
    end

  end

end

