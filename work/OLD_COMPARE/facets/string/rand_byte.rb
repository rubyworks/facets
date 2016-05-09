
class String

  # Return a random byte of _self_.
  #
  #   "Ruby rules".rand_byte  #=> 121
  #
  def rand_byte
    self[rand( size )]
  end

  # Destructive rand_byte. Delete a random byte of _self_ and return it.
  #
  #   s = "Ruby rules"
  #   s.rand_byte!      #=> 121
  #   s                 #=> "Rub rules"
  #
  def rand_byte!
    i = rand( size )
    rv = self[i,1]
    self[i,1] = ''
    rv
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

    def test_rand_byte
      s = 'ab'
      r = s.rand_byte
      assert( r == 97 || r == 98 )
    end

    def test_rand_byte
      s = 'ab'
      r = s.rand_byte
      assert( r == 97 || r == 98 )
      assert( s = 'a' || s = 'b' )
    end

  end

=end
