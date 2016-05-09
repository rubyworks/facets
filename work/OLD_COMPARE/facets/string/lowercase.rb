#--
# Credit goes to Phil Tomson.
#++
require 'facets/string/downcase'

class String

  # Alias for #downcase? method.
  alias_method( :lowercase?, :downcase? )

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

    def test_lowercase?
      assert( 'abc'.lowercase? )
    end

  end

=end
