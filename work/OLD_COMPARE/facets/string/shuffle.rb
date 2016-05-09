require 'facets/array/shuffle'

class String

  # Return the string with seperated sections arranged
  # in a random order. The default seperation is by character.
  #
  #   "Ruby rules".shuffle  #=> "e lybRsuur"
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


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
=begin test

  require 'test/unit'

  class TCString < Test::Unit::TestCase

    def test_shuffle
      assert_nothing_raised { "abc 123".shuffle }
      #assert_nothing_raised { "abc 123".shuffle! }
    end

  end

=end
