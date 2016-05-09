
class String

  def self.interpolate(&str)
    eval "%{#{str.call}}", str.binding
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

    def test_interpolate
      a = 1
      assert_equal('this is 1', String.interpolate{ 'this is #{a}' })
    end

  end

=end
