require 'facets/string/blank'

class String
  alias_method :whitespace?, :blank?
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

    def test_whitespace?
      assert( ! "xyz".whitespace? )
      assert( "     ".whitespace? )
    end

  end

=end
