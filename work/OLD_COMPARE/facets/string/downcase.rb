#--
# Credit goes to Phil Tomson.
#++
class String

  # Return true if the string is lowercase (downcase), otherwise false.
  #
  #   "THIS".downcase?  #=> false
  #   "This".downcase?  #=> false
  #   "this".downcase?  #=> true
  #
  def downcase?
    downcase == self
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

    def test_downcase?
      assert( 'abc'.downcase? )
    end

  end

=end
