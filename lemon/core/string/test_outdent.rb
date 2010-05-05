Covers 'facets/string/outdent'

Case String do

  ex1 = <<-EOF
    I must go down to the seas again
      The lonely sea and the sky
    And all I want is a tall ship
      And a star to steer her by
  EOF

  ex2 = <<-EOF
     "Eek!"
  She cried
    As the mouse quietly scurried
by.
  EOF

  Unit :outdent => "simple examples" do
    "   xyz".outdent(-1).assert == "    xyz"
    "   xyz".outdent(0).assert  == "   xyz"
    "   xyz".outdent(1).assert  == "  xyz"
    "   xyz".outdent(2).assert  == " xyz"
    "   xyz".outdent(3).assert  == "xyz"
    "   xyz".outdent(4).assert  == "xyz"
  end

  Unit :outdent => "large example outdented one space" do
    expected = <<-EOF
   I must go down to the seas again
     The lonely sea and the sky
   And all I want is a tall ship
     And a star to steer her by
    EOF
    actual = ex1.outdent(1)
    actual.assert == expected
  end

  Unit :outdent => "large example outdented four spaces" do
    expected = <<-EOF
I must go down to the seas again
  The lonely sea and the sky
And all I want is a tall ship
  And a star to steer her by
    EOF
    actual = ex1.outdent(4)
    actual.assert == expected
  end

  Unit :outdent => "outdent larger than current indention" do
    expected = <<-EOF
"Eek!"
She cried
As the mouse quietly scurried
by.
    EOF
    actual = ex2.outdent(100)
    actual.assert == expected
  end

end

