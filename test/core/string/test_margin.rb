require 'facets/string/margin'
require 'test/unit'

class TC_String_Margin < Test::Unit::TestCase

  def test_margin
    s = %q{
          |ABC
          |123
          |TEST
          }.margin
    assert_equal( "ABC\n123\nTEST", s )

    s = %q{
            |ABC
          |123
                |TEST
          }.margin
    assert_equal( "ABC\n123\nTEST", s )

    s = %q{|ABC
          |123
          |TEST
    }.margin
    assert_equal( "ABC\n123\nTEST", s )

    s = %q{
          |ABC
          |123
          |TEST}.margin
    assert_equal( "ABC\n123\nTEST", s )

    s = %q{|ABC
          |123
          |TEST}.margin
    assert_equal( "ABC\n123\nTEST", s )

    s = %q{   |ABC
          |123
          |TEST}.margin
    assert_equal( "ABC\n123\nTEST", s )

    s = %q{ABC
          |123
          |TEST
          }.margin
    assert_equal( "ABC\n123\nTEST", s )
  end

  #

  def test_spacing
    s = %q{
          | ABC
          | 123
          | TEST
          }.margin
    assert_equal( " ABC\n 123\n TEST", s )

    s = %q{
          |ABC
          |123
          |TEST
          }.margin(1)
    assert_equal( " ABC\n 123\n TEST", s )

    s = %q{
          |ABC
          |123
          |TEST
          }.margin(2)
    assert_equal( "  ABC\n  123\n  TEST", s )

    s = %q{ ABC
          - 123
          - TEST
          }.margin
    assert_equal( " ABC\n 123\n TEST", s )
  end

  #

  def test_random_placement
    @volly = {}
    100.times{ |n|
      k = []
      a = []
      5.times{ |i|
        k << ( ( ' ' * Integer(rand*10) ) + '|' + i.to_s )
        a << ( i.to_s )
      }
      @volly[k.join("\n")] = a.join("\n")
    }
    @volly.each{ |k,v|
      assert_equal( v, k.margin )
    }
  end

end

