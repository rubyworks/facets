#--
# Credit goes to Phil Tomson.
#++

class String

  # Is the string upcase/uppercase?
  #
  #   "THIS".upcase?  #=> true
  #   "This".upcase?  #=> false
  #   "this".upcase?  #=> false
  #
  def upcase?
    self.upcase == self
  end

  # Alias for #upcase? method.
  alias_method( :uppercase?, :upcase? )

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

    def test_upcase?
      assert( 'ABC'.upcase? )
    end

    def test_uppercase?
      assert( 'ABC'.uppercase? )
    end

  end

=end
