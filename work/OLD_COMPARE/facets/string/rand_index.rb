class String
  # Return a random string index.
  #
  #   "Ruby rules".rand_index  #=> 3
  #
  def rand_index
    rand( size )
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

    def test_rand_index
      10.times { assert( (0..2).include?( 'abc'.rand_index ) ) }
    end

  end

=end
