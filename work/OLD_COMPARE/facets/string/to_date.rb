
class String

  def to_date
    require 'date'
    require 'parsedate'
    ::Date::civil(*ParseDate.parsedate(self)[0..2])
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

    def test_to_date
      s = "2005-10-31"
      d = s.to_date
      assert_equal( 31, d.day )
      assert_equal( 10, d.month )
      assert_equal( 2005, d.year )
    end

  end

=end
