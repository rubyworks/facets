
class String

  def self.bra2ket
    @bra2ket ||= { '['=>']', '('=>')', '{'=>'}', '<'=>'>' }
  end

  # Return a new string embraced by given brakets.
  # If only one bracket char is given it will be placed
  # on either side.
  #
  #   "wrap me".bracket('{')        #=> "{wrap me}"
  #   "wrap me".bracket('--','!')   #=> "--wrap me!"
  #
  def bracket(bra, ket=nil)
    #ket = String.bra2ket[$&] if ! ket && /^[\[({<]$/ =~ bra
    ket = String.bra2ket[bra] unless ket
    "#{bra}#{self}#{ket ? ket : bra}"
  end

  # Inplace version of #braket.
  def bracket!(bra, ket=nil)
    self.replace( self.bracket(bra, ket) )
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

    def test_bracket
      assert_equal( '#X#', 'X'.bracket('#') )
      assert_equal( 'xX!', 'X'.bracket('x','!') )
      assert_equal( '{X}', 'X'.bracket('{','}') )
      assert_equal( '<X>', 'X'.bracket('<') )
      assert_equal( '(X)', 'X'.bracket('(') )
      assert_equal( '[X]', 'X'.bracket('[') )
      assert_equal( '{X}', 'X'.bracket('{') )
    end

    def test_braket!
      a = 'X' ; a.bracket!('#')
      assert_equal( '#X#', a )
      a = 'X' ; a.bracket!('x','!')
      assert_equal( 'xX!', a )
      a = 'X' ; a.bracket!('{','}')
      assert_equal( '{X}', a )
      a = 'X' ; a.bracket!('<')
      assert_equal( '<X>', a )
      a = 'X' ; a.bracket!('(')
      assert_equal( '(X)', a )
      a = 'X' ; a.bracket!('[')
      assert_equal( '[X]', a )
      a = 'X' ; a.bracket!('{')
      assert_equal( '{X}', a )
    end

  end

=end
