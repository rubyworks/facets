Covers 'facets/string/unindent'

Case String do

  Concern "Single-line indentation"

  Unit :unindent => "removes space indentation" do
    "\s\sabc".unindent.assert == "abc"
  end

  Unit :unindent => "removes_tab_indentation" do
    "\tabc".unindent.assert == "abc"
  end

  Unit :unindent => "removes space and tab indentation" do
    "\t\sabc".unindent.assert == "abc"
  end

  Concern "Multi-line indentation"

  Unit :unindent => "removes indentation" do
    "\tabc\n\tabc".unindent.assert == "abc\nabc"
  end

  Unit :unindent => "keeps relative indentation" do
    "\tabc\n\t\tabc".unindent.assert == "abc\n\tabc"
  end

  Unit :unindent => "ignores blank lines for indent calculation" do
    "\n\tabc\n\n\t\tabc\n".unindent.assert == "\nabc\n\n\tabc\n"
  end

  Concern "Inplace method"

  Unit :unindent! => "modifies string in place" do
    str = "\s\sabc"
    str.unindent!
    str.assert == "abc"
  end

  Concern "Complex examples"

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

  Unit :unindent => "simple examples" do
    "   xyz".unindent(-1).assert == "    xyz"
    "   xyz".unindent(0).assert  == "   xyz"
    "   xyz".unindent(1).assert  == "  xyz"
    "   xyz".unindent(2).assert  == " xyz"
    "   xyz".unindent(3).assert  == "xyz"
    "   xyz".unindent(4).assert  == "xyz"
  end

  Unit :unindent => "large example unindented one space" do
    expected = <<-EOF
   I must go down to the seas again
     The lonely sea and the sky
   And all I want is a tall ship
     And a star to steer her by
    EOF
    actual = ex1.unindent(1)
    actual.assert == expected
  end

  Unit :unindent => "large example unindented four spaces" do
    expected = <<-EOF
I must go down to the seas again
  The lonely sea and the sky
And all I want is a tall ship
  And a star to steer her by
    EOF
    actual = ex1.unindent(4)
    actual.assert == expected
  end

  Unit :unindent => "unindent larger than current indention" do
    expected = <<-EOF
"Eek!"
She cried
As the mouse quietly scurried
by.
    EOF
    actual = ex2.unindent(100)
    actual.assert == expected
  end

end

