require 'facets/hash/zip'
require 'facets/string/shatter'
require 'facets/kernel/maybe'

# = Randomization Extensions
#
# This library extends Array, String, Hash and other classes with randomization
# methods.
#
# Credit for this work is due to:
#
# * Ilmari Heikkinen
# * Christian Neukirchen
# * Thomas Sawyer

class Random

  class << self
    # Alias for Kernel#rand.
    alias_method :number, :rand

    public :number
  end

  # Module method to generate a random letter.
  #
  #   Random.letter  #~> "q"
  #   Random.letter  #~> "r"
  #   Random.letter  #~> "a"
  #
  def self.letter
    (Random.number(26) + (Random.number(2) == 0 ? 65 : 97) ).chr
  end

  # Random extensions for Range class.
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
      if first.respond_to?(:random_delta)
        begin
          first.random_delta(last, exclude_end?)
        rescue
          to_a.sample
        end
      else
        to_a.sample
      end
    end
  end

  # Random extensions for Integer class.
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

  # Random extensions for Numeric class.
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

  # Random extensions for Array class.
  #
  module ArrayExtensions

    # Destructive version of Array#sample. Removes and returns
    # a random element, or n random exclusive elements.
    #
    #   a = [1,2,3,4]
    #   a.sample!        #~> 2
    #   a                #~> [1,3,4]
    #
    #   a = [1,2,3,4,5]
    #   a.sample!(3)     #~> [2,4,1]
    #   a                #~> [3,5]
    #
    def sample!(n=nil)
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

    # @deprecated Use Array#sample instead.
    #   Scheduled for removal after 2027-09-30.
    def at_rand
      warn "Array#at_rand is deprecated. Use Array#sample instead. It will be removed after 2027-09-30.", uplevel: 1
      sample
    end

    # @deprecated Use Array#sample! instead.
    #   Scheduled for removal after 2027-09-30.
    def at_rand!
      warn "Array#at_rand! is deprecated. Use Array#sample! instead. It will be removed after 2027-09-30.", uplevel: 1
      sample!
    end

    # @deprecated Use Array#sample instead.
    #   Scheduled for removal after 2027-09-30.
    def pick(n=nil)
      warn "Array#pick is deprecated. Use Array#sample instead. It will be removed after 2027-09-30.", uplevel: 1
      n ? sample(n) : sample
    end

    # @deprecated Use Array#sample! instead.
    #   Scheduled for removal after 2027-09-30.
    def pick!(n=nil)
      warn "Array#pick! is deprecated. Use Array#sample! instead. It will be removed after 2027-09-30.", uplevel: 1
      sample!(n)
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
    #   [1, 2, 3, 4].rand_subset(1)        #~> [2]
    #   [1, 2, 3, 4].rand_subset(4)        #~> [2, 1, 3, 4]
    #   [1, 2, 3, 4].rand_subset           #~> [1, 3, 4]
    #   [1, 2, 3, 4].rand_subset           #~> [2, 3]
    #
    def rand_subset(number=nil, exclusive=true)
      number = Random.number(size) unless number
      number = number.to_int
      return sort_by{rand}.slice(0,number) if exclusive
      ri =[]; number.times { |n| ri << Random.number(size) }
      return values_at(*ri)
    end

    # Generates random subarrays. Uses random numbers and bit-
    # fiddling to assure performant uniform distributions even
    # for large arrays.
    #
    #   a = *1..5
    #   a.rand_subarrays(2) #=> [[3, 4, 5], []]
    #   a.rand_subarrays(3) #=> [[1], [1, 4, 5], [2, 3]]
    #
    # CREDIT: Michael Kohl
    def rand_subarrays(n=1)
      raise ArgumentError, "negative argument" if n < 0
      (1..n).map do
        r = rand(2**self.size)
        self.select.with_index { |_, i| r[i] == 1 }
      end
    end

  end

  # Random extensions for Hash class.
  #
  module HashExtensions
    # Returns a random key.
    #
    #   {:one => 1, :two => 2, :three => 3}.rand_key  #~> :three
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

    # Returns a random key-value pair.
    #
    #   {:one => 1, :two => 2, :three => 3}.rand_pair  #~> [:one, 1]
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
    #   a.rand_value!  #~> 2
    #   a              #~> {:one => 1, :three => 3}
    #
    def rand_value!
      k,v = rand_pair
      delete( k )
      return v
    end

    # Returns a copy of the hash with _values_ arranged
    # in new random order.
    #
    #   h = {:a=>1, :b=>2, :c=>3}
    #   h.shuffle  #~> {:b=>2, :c=>1, :a>3}
    #
    def shuffle
      ::Hash.zip( keys.sort_by{Random.number}, values.sort_by{Random.number} )
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

  # Random extensions for String class.
  #
  module StringExtensions

    #
    def self.included(base)
      base.extend(Self)
    end

    # Class-level methods.
    module Self
      # Returns a randomly generated string. One possible use is
      # password initialization. Takes a max length of characters
      # (default 8) and an optional valid char Regexp (default /\w\d/).
      #
      #   String.random    #~> 'dd4qed4r'
      #
      # CREDIT George Moschovitis
      def random(max_length = 8, char_re = /[\w\d]/)
        raise ArgumentError.new('second argument must be a regular expression') unless char_re.is_a?(Regexp)
        string = ""
        while string.length < max_length
            ch = Random.number(255).chr
            string << ch if ch =~ char_re
        end
        return string
      end

      # Generate a random binary string of +n_bytes+ size.
      #
      # CREDIT: Guido De Rosa
      def random_binary(n_bytes)
        ( Array.new(n_bytes){ rand(0x100) } ).pack('c*')
      end
    end

    # Return a random separation of the string.
    # Default separation is by character.
    #
    #   "Ruby rules".at_rand(' ')  #~> ["Ruby"]
    #
    def at_rand( separator=// )
      self.split(separator,-1).sample
    end

    # Return a random separation while removing it
    # from the string. Default separation is by character.
    #
    #   s = "Ruby rules"
    #   s.at_rand!(' ')    #~> "Ruby"
    #   s                  #~> "rules"
    #
    def at_rand!( separator=// )
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

    # Return the string with separated sections arranged
    # in a random order. The default separation is by character.
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
