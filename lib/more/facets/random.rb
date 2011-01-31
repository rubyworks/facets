require 'facets/hash/zipnew'
require 'facets/string/shatter'
require 'facets/kernel/maybe'

# = Randomization Extensions
#
# This library extends Array, String, Hash and other classes with randomization
# methods. Most of the methods are of one of two kinds. Either they "pick" a
# random element from the reciever or they randomly "shuffle" the reciever.
#
# The most common example is Array#shuffle, which simply randmomizes the
# order of an array's elements.
#
#   [1,2,3].shuffle  #~> [2,3,1]
#
# The other methods do similar things for their respective classes.
#
# The classes are all extended via mixins which have been created within
# Ruby's Random class.
#
# Credit for this work is due to:
#
# * Ilmari Heikkinen
# * Christian Neukirchen
# * Thomas Sawyer
#
# NOTE: Inline QED tests are almost pointless here b/c... yea, it's random.
# So indtead of the usual `#=>` we use `#~>` which means approx. equal and
# prevens QED from making a hard assertion.

class Random

  class << self
    # Alias for Kernel#rand.
    alias_method :number, :rand

    public :number
  end

  ##def self.number(*args)
  ##  ::Kernel.rand(*args)
  ##end

  # Module method to generate a random letter.
  #
  #   Random.letter  #~> "q"
  #   Random.letter  #~> "r"
  #   Random.letter  #~> "a"
  #
  def self.letter
    (Random.number(26) + (Random.number(2) == 0 ? 65 : 97) ).chr
  end

  #
  module RangeExtensions
    # Return a random element from the range.
    #
    #   (1..4).at_rand           #~> 2
    #   (1..4).at_rand           #~> 4
    #
    #   (1.5..2.5).at_rand       #~> 2.06309842754533
    #   (1.5..2.5).at_rand       #~> 1.74976944931541
    #
    #   ('a'..'z').at_rand       #~> 'q'
    #   ('a'..'z').at_rand       #~> 'f'
    #
    # CREDIT: Lavir the Whiolet, Thomas Sawyer
    def at_rand
      first, last = first(), last()
      if first.respond_to?(:random_delta)  # TODO: work on this!!!
        begin
          first.random_delta(last, exclude_end?)
        rescue
          to_a.at_rand
        end
      else
        to_a.at_rand
      end
      ##elsif first.respond_to?(:succ)
      ##  # optimized algorithm
      ##  if (Fixnum === first || Bignum === first) &&
      ##     (Fixnum === last  || Bignum === last)
      ##    last -= 1 if exclude_end?
      ##    return nil if last < first
      ##    return Random.number(last - first + 1) + first
      ##  end
      ##  # standard algorithm
      ##  return to_a.at_rand
      ##elsif Numeric === first && Numeric === last
      ##  return nil if last < first
      ##  return nil if exclude_end? && last == first
      ##  return (last - first) * Random.number + first
      ##else
      ##  return nil
      ##end
    end
  end

  #
  module IntegerExtensions
    #
    def random_delta(last, exclude_end)
      first = self
      last -= 1 if exclude_end
      return nil if last < first
      return Random.number(last - first + 1) + first
    end
  end

  #
  module NumericExtensions
    #
    def random_delta(last, exclude_end)
      first = self
      return nil if last < first
      return nil if exclude_end && last == first
      return (last - first) * Random.number + first
    end
  end

  #
  module ArrayExtensions
    # Return a random element from the array.
    #
    #   [1, 2, 3, 4].at_rand           #~> 2
    #   [1, 2, 3, 4].at_rand           #~> 4
    #
    def at_rand
      at(Random.number(size))
    end

    # Same as #at_rand, but acts in place removing a
    # random element from the array.
    #
    #   a = [1,2,3,4]
    #   a.at_rand!       #~> 2
    #   a                #~> [1,3,4]
    #
    def at_rand!
      return delete_at( Random.number( size ) )
    end

    # Similar to #at_rand, but will return an array of randomly
    # picked exclusive elements if given a number.
    def pick(n=nil)
      if n
        a = self.dup
        a.pick!(n)
      else
        at(Random.number(size))
      end
    end

    # Similar to #at_rand!, but given a number will return
    # an array of exclusive elements.
    def pick!(n=nil)
      if n
        if n > self.size
          r = self.dup
          self.replace([])
          r
        else
          r = []
          n.times { r << delete_at(Random.number(size)) }
          r
        end
      else
        delete_at(Random.number(size))
      end
    end

    # Random index.
    #
    def rand_index
      Random.number(size)
    end

    # Returns a random subset of an Array. If a _number_
    # of elements is specified then returns that number of
    # elements, otherwise returns a random number of elements
    # upto the size of the Array.
    #
    # By defualt the returned values are exclusive of
    # each other, but if _exclusive_ is set to <tt>false</tt>,
    # the same values can be choosen more than once.
    #
    # When _exclusive_ is <tt>true</tt> (the default) and the
    # _number_ given is greater than the size of the array,
    # then all values are returned.
    #
    #   [1, 2, 3, 4].rand_subset(1)        #~> [2]
    #   [1, 2, 3, 4].rand_subset(4)        #~> [2, 1, 3, 4]
    #   [1, 2, 3, 4].rand_subset           #~> [1, 3, 4]
    #   [1, 2, 3, 4].rand_subset           #~> [2, 3]
    #
    def rand_subset( number=nil, exclusive=true )
      number = Random.number(size) unless number
      number = number.to_int
      #return self.dup if (number >= size and exlusive)
      return sort_by{rand}.slice(0,number) if exclusive
      ri =[]; number.times { |n| ri << Random.number(size) }
      return values_at(*ri)
    end

    # Randomize the order of an array.
    #
    #   [1,2,3,4].shuffle  #~> [2,4,1,3]
    #
    def shuffle
      dup.shuffle!
      #sort_by{Random.number}
    end

    # As with #shuffle but modifies the array in place.
    # The algorithm used here is known as a Fisher-Yates shuffle.
    #
    #   a = [1,2,3,4]
    #   a.shuffle!
    #
    #   a  #~> [2,4,1,3]
    #
    # CREDIT Niel Spring
    def shuffle!
      s = size
      each_index do |j|
        i = Random.number(s-j)
        #self[j], self[j+i] = self[j+i], self[j]
        tmp = self[j]
        self[j] = self[j+i]
        self[j+i] = tmp
      end
      self
    end

  end

  #
  module HashExtensions
    # Returns a random key.
    #
    #   {:one => 1, :two => 2, :three => 3}.pick_key  #~> :three
    #
    def rand_key
      keys.at(Random.number(keys.size))
    end

    # Delete a random key-value pair, returning the key.
    #
    #   a = {:one => 1, :two => 2, :three => 3}
    #   a.rand_key!  #~> :two
    #   a            #~> {:one => 1, :three => 3}
    #
    def rand_key!
      k,v = rand_pair
      delete(k)
      return k
    end

    alias_method( :pick_key, :rand_key! )

    # Returns a random key-value pair.
    #
    #   {:one => 1, :two => 2, :three => 3}.pick  #~> [:one, 1]
    #
    def rand_pair
      k = rand_key
      return k, fetch(k)
    end

    # Deletes a random key-value pair and returns that pair.
    #
    #   a = {:one => 1, :two => 2, :three => 3}
    #   a.rand_pair!  #~> [:two, 2]
    #   a             #~> {:one => 1, :three => 3}
    #
    def rand_pair!
      k,v = rand_pair
      delete( k )
      return k,v
    end

    alias_method( :pick_pair, :rand_pair! )

    # Returns a random hash value.
    #
    #   {:one => 1, :two => 2, :three => 3}.rand_value  #~> 2
    #   {:one => 1, :two => 2, :three => 3}.rand_value  #~> 1
    #
    def rand_value
      fetch(rand_key)
    end

    # Deletes a random key-value pair and returns the value.
    #
    #   a = {:one => 1, :two => 2, :three => 3}
    #   a.at_rand!  #~> 2
    #   a           #~> {:one => 1, :three => 3}
    #
    def rand_value!
      k,v = rand_pair
      delete( k )
      return v
    end

    alias_method( :pick, :rand_value! )

    alias_method( :at_rand, :rand_value )
    alias_method( :at_rand!, :rand_value! )

    # Returns a copy of the hash with _values_ arranged
    # in new random order.
    #
    #   h = {:a=>1, :b=>2, :c=>3}
    #   h.shuffle  #~> {:b=>2, :c=>1, :a>3}
    #
    def shuffle
      ::Hash.zipnew( keys.sort_by{Random.number}, values.sort_by{Random.number} )
    end

    # Destructive shuffle_hash. Arrange the values in
    # a new random order.
    #
    #   h = {:a => 1, :b => 2, :c => 3}
    #   h.shuffle!
    #   h  #~> {:b=>2, :c=>1, :a=>3}
    #
    def shuffle!
      self.replace(shuffle)
    end

  end

  #
  module StringExtensions

    #
    def self.included(base)
      base.extend(Self)
    end

    # Class-level methods.
    module Self
      # Returns a randomly generated string. One possible use is
      # password initialization. Takes a max legnth of characters
      # (default 8) and an optional valid char Regexp (default /\w\d/).
      #
      #   String.random    #~> 'dd4qed4r'
      #
      # CREDIT George Moschovitis
      #--
      # TODO: This is not very efficient. Better way?
      #++
      def random(max_length = 8, char_re = /[\w\d]/)
        raise ArgumentError.new('char_re must be a regular expression!') unless char_re.is_a?(Regexp)
        string = ""
        while string.length < max_length
            ch = Random.number(255).chr
            string << ch if ch =~ char_re
        end
        return string
      end
    end

    # Return a random separation of the string.
    # Default separation is by charaacter.
    #
    #   "Ruby rules".at_rand(' ')  #~> ["Ruby"]
    #
    def at_rand( separator=// )
      #separator = self.class.patterns( separator )
      self.split(separator,-1).at_rand
    end

    # Return a random separation while removing it
    # from the string. Default separation is by character.
    #
    #   s = "Ruby rules"
    #   s.at_rand!(' ')    #~> "Ruby"
    #   s                  #~> "rules"
    #
    def at_rand!( separator=// )
      #separator = self.class.patterns( separator )
      a = self.shatter( separator )
      w = []; a.each_with_index { |s,i| i % 2 == 0 ? w << s : w.last << s }
      i = Random.number(w.size)
      r = w.delete_at( i )
      self.replace( w.join('') )
      return r
    end

    # Return a random byte of _self_.
    #
    #   "Ruby rules".rand_byte  #~> 121
    #
    def rand_byte
      self[Random.number(size)]
    end

    # Destructive rand_byte. Delete a random byte of _self_ and return it.
    #
    #   s = "Ruby rules"
    #   s.rand_byte!      #~> 121
    #   s                 #~> "Rub rules"
    #
    def rand_byte!
      i = Random.number(size)
      rv = self[i,1]
      self[i,1] = ''
      rv
    end

    # Return a random string index.
    #
    #   "Ruby rules".rand_index  #~> 3
    #
    def rand_index
      Random.number(size)
    end

    # Return the string with seperated sections arranged
    # in a random order. The default seperation is by character.
    #
    #   "Ruby rules".shuffle  #~> "e lybRsuur"
    #
    def shuffle(separator=//)
      split(separator).shuffle.join('')
    end

    # In place version of shuffle.
    #
    def shuffle!(separator=//)
      self.replace( shuffle(separator) )
    end

  end

end

class Range   ; include Random::RangeExtensions   ; end
class Array   ; include Random::ArrayExtensions   ; end
class Hash    ; include Random::HashExtensions    ; end
class String  ; include Random::StringExtensions  ; end
class Integer ; include Random::IntegerExtensions ; end
class Numeric ; include Random::NumericExtensions ; end

# Copyright (c) 2005 Ilmari Heikkinen, Christian Neukirchen, Thomas Sawyer
