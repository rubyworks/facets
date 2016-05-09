
class String

  # Interpret common affirmative string meanings as true,
  # otherwise false. Balnk sapce and case are ignored.
  # The following strings that will return true:
  #
  #   <tt>true</tt>,<tt>yes</tt>,<tt>on</tt>,<tt>t</tt>,<tt>1</tt>,<tt>y</tt>,<tt>==</tt>
  #
  # Examples:
  #
  #   "true".to_b   #=> true
  #   "yes".to_b    #=> true
  #   "no".to_b     #=> false
  #   "123".to_b    #=> false
  #
  def to_b
    case self.downcase.strip
    when 'true', 'yes', 'on', 't', '1', 'y', '=='
      return true
    when 'nil', 'null'
      return nil
    else
      return false
    end
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

    def test_to_b
      assert( 'true'.to_b )
      assert( 'True'.to_b )
      assert( 'yes'.to_b )
      assert( 'YES'.to_b )
      assert( 'on'.to_b )
      assert( 'ON'.to_b )
      assert( 't'.to_b )
      assert( '1'.to_b )
      assert( 'y'.to_b )
      assert( 'Y'.to_b )
      assert( '=='.to_b )
      assert( ! 'nil'.to_b )
      assert( ! 'false'.to_b )
      assert( ! 'blahblahtrueblah'.to_b )
      assert_equal( nil, 'nil'.to_b )
      assert_equal( nil, 'null'.to_b )
    end

  end

=end
