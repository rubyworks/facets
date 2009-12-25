require 'facets/string/expand_tab'
require 'test/unit'

class TC_String_Expand_Tab < Test::Unit::TestCase

  def setup
    @tabs = <<-EOF

\tOne tab
 \tOne space and one tab
    \t Six spaces, a tab, and a space
    EOF
  end  # def setup

  def test_expand_tabs_1
    expected = <<-EOF

        One tab
        One space and one tab
         Six spaces, a tab, and a space
    EOF
    assert_equal(expected, @tabs.expand_tabs)
    assert_equal(expected, @tabs.expand_tabs(8))
  end

  def test_expand_tabs_2
    expected = <<-EOF

    One tab
    One space and one tab
         Six spaces, a tab, and a space
    EOF
    assert_equal(expected, @tabs.expand_tabs(4))
  end

  def test_expand_tabs_3
    expected = <<-EOF

                One tab
                One space and one tab
                 Six spaces, a tab, and a space
    EOF
    assert_equal(expected, @tabs.expand_tabs(16))
  end

  def test_expand_tabs_4
    expected = <<-EOF

 One tab
  One space and one tab
      Six spaces, a tab, and a space
    EOF
    assert_equal(expected, @tabs.expand_tabs(1))
  end

  def test_expand_tabs_5
    expected = <<-EOF

One tab
 One space and one tab
     Six spaces, a tab, and a space
    EOF
    assert_equal(expected, @tabs.expand_tabs(0))
  end

end

