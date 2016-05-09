
class String

  # Iterates through each character.
  def each_char  # :yield:
    split(//).each { |c|
      yield( c )
    }
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

    def test_each_char
      a = []
      i = "this"
      i.each_char{ |w| a << w }
      assert_equal( ['t', 'h', 'i', 's'], a )
    end

  end

=end
