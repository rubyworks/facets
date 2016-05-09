# CREDIT Phil Tomson

class String

  # Return true if the string is capitalized, otherwise false.
  #
  #   "THIS".capitalized?  #=> true
  #   "This".capitalized?  #=> true
  #   "this".capitalized?  #=> false

  def capitalized?
    self =~ /^[A-Z]/
  end

end #class String


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
=begin test

  require 'test/unit'

  class TCString < Test::Unit::TestCase

    def test_capitalized?
      assert( 'Abc'.capitalized? )
    end

  end

=end
