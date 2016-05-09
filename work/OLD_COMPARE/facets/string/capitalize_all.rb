# CREDIT Richard Laugesen

class String
  
  # Capitalize all words (or other patterned divisions) of a string.
  #
  #   "this is a test".capitalize_all  #=> "This Is A Test"

  def capitalize_all( pattern=$;, *limit )
    split(pattern, *limit).select{ |w| w.capitalize! || w }.join(" ")
  end

end


=begin test

  require 'test/unit'

  class TestCapitalizeAll < Test::Unit::TestCase
    def test_01
      r = "try this out".capitalize_all
      x = "Try This Out"
      assert_equal(x,r)
    end
  end

=end


