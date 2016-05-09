
class String

  # Escape string for Regexp use.
  def regesc
    Regexp.escape( self )
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

    def test_001
      a = "?"
      b = /#{a.regesc}/
      assert( b =~ "?" )
    end

  end

=end
