require 'facets/string/outdent'
require 'test/unit'

class TC_String_Outdent < Test::Unit::TestCase

  def setup
    @poem1 = <<-EOF
    I must go down to the seas again
      The lonely sea and the sky
    And all I want is a tall ship
      And a star to steer her by
    EOF

    @poem2 = <<-EOF
       "Eek!"
    She cried
      As the mouse quietly scurried
  by.
    EOF
  end  # def setup

  def test_outdent_0
    assert_equal("    xyz", "   xyz".outdent(-1))
    assert_equal("   xyz", "   xyz".outdent(0))
    assert_equal("  xyz", "   xyz".outdent(1))
    assert_equal(" xyz", "   xyz".outdent(2))
    assert_equal("xyz", "   xyz".outdent(3))
    assert_equal("xyz", "   xyz".outdent(4))
  end

  def test_outdent_1
    expected = <<-EOF
   I must go down to the seas again
     The lonely sea and the sky
   And all I want is a tall ship
     And a star to steer her by
    EOF
    actual = @poem1.outdent(1)
    assert_equal(expected, actual)
  end

  def test_outdent_2
    expected = <<-EOF
I must go down to the seas again
  The lonely sea and the sky
And all I want is a tall ship
  And a star to steer her by
    EOF
    actual = @poem1.outdent(4)
    assert_equal(expected, actual)
  end

  def test_outdent_3
    expected = <<-EOF
"Eek!"
She cried
As the mouse quietly scurried
by.
    EOF
    actual = @poem2.outdent(100)
    assert_equal(expected, actual)
  end

end

