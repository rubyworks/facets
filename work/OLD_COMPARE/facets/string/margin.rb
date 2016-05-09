
class String

  # Provides a margin controlled string.
  #
  #   x = %Q{
  #         | This
  #         |   is
  #         |     margin controlled!
  #         }.margin
  #
  #--
  # This may still need a bit of tweaking.
  #++
  def margin(n=0)
    d = /\A.*\n\s*(.)/.match( self )[1]
    d = /\A\s*(.)/.match( self)[1] unless d
    return '' unless d
    if n == 0
      gsub(/\n\s*\Z/,'').gsub(/^\s*[#{d}]/, '')
    else
      gsub(/\n\s*\Z/,'').gsub(/^\s*[#{d}]/, ' ' * n)
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

=end
