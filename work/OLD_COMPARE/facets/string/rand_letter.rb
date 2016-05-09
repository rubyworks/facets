class String

  # Module method to generate a random letter.
  #
  #   String::Random.rand_letter  #=> "q"
  #   String::Random.rand_letter  #=> "r"
  #   String::Random.rand_letter  #=> "a"
  #
  def self.rand_letter
    (rand(26) + (rand(2) == 0 ? 65 : 97) ).chr
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

  class TC01 < Test::Unit::TestCase

    def test_String_rand_letter
      100.times { |i| assert( /[a-zA-z]/ =~ String.rand_letter ) }
    end

  end

=end
