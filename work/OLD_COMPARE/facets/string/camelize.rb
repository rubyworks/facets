
class String

  # Variation of coverting a string to camelcase. This is unlike
  # #camelcase in that it is geared toward code reflection use.
  #
  #   "this/is_a_test".camelize  #=> This::IsATest
  #
  def camelize
    #to_s.gsub(/(^|_)(.)/){$2.upcase}
    to_s.gsub(/\/(.?)/){ "::" + $1.upcase }.gsub(/(^|_)(.)/){ $2.upcase }
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

    def test_camelize
      assert_equal( 'ThisIsIt', 'this_is_it'.camelize )
    end

  end

=end
