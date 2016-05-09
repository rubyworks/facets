
require 'facets/array/at_rand'
require 'facets/string/patterns'
require 'facets/string/shatter'

class String

  # Return a random separation of the string.
  # Default separation is by charaacter.
  #
  #   "Ruby rules".at_rand(' ')  #=> ["Ruby"]
  #
  def at_rand( separator=// )
    separator = self.class.patterns( separator )
    self.split(separator,-1).at_rand
  end

  # Return a random separation while removing it
  # from the string. Default separation is by character.
  #
  #   s = "Ruby rules"
  #   s = at_rand!(' ')  #=> "Ruby"
  #   s                  #=> "rules"
  #
  def at_rand!( separator=// )
    separator = self.class.patterns( separator )
    a = self.shatter( separator )
    w = []; a.each_with_index { |s,i| i % 2 == 0 ? w << s : w.last << s }
    i = rand( w.size )
    r = w.delete_at( i )
    self.replace( w.join('') )
    return r
  end

end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
=begin test

  require 'test/unit'

  class TCString < Test::Unit::TestCase

    def test_at_rand
      a = '12345'
      20.times{ assert_nothing_raised{ a.at_rand } }
      20.times{ assert( a.include?( a.at_rand ) ) }
    end

    def test_at_rand!
      x = 'ab'
      r = x.at_rand!
      assert( r == 'a' || r == 'b' )
      assert( x == 'a' || x == 'b' )
    end

  end

=end
