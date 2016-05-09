
class String

  # Is this string just whitespace?
  #
  #   "abc".blank?  #=> false
  #   "   ".blank?  #=> true
  #
  def blank?
    self !~ /\S/
  end
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

    def test_blank?
      assert( ! "xyz".blank? )
      assert( "     ".blank? )
    end

  end

=end
