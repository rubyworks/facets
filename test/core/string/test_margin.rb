covers 'facets/string/margin'

test_case String do

  method :margin do

    test do
      s = %q{
            |ABC
            |123
            |TEST
            }.margin
      s.assert == "ABC\n123\nTEST"
    end

    test do
      s = %q{
              |ABC
            |123
                  |TEST
            }.margin
      s.assert == "ABC\n123\nTEST"
    end

    test do
      s = %q{|ABC
            |123
            |TEST
      }.margin
      s.assert == "ABC\n123\nTEST"
    end

    test do
      s = %q{
            |ABC
            |123
            |TEST}.margin
      s.assert == "ABC\n123\nTEST"
    end

    test do
      s = %q{|ABC
            |123
            |TEST}.margin
      s.assert == "ABC\n123\nTEST"
    end

    test do
      s = %q{   |ABC
            |123
            |TEST}.margin
      s.assert == "ABC\n123\nTEST"
    end

    test do
      s = %q{ABC
            |123
            |TEST
            }.margin
      s.assert == "ABC\n123\nTEST"
    end

    test "spacing" do
      s = %q{
            | ABC
            | 123
            | TEST
            }.margin
      s.assert == " ABC\n 123\n TEST"
    end

    test "spacing" do
      s = %q{
            |ABC
            |123
            |TEST
            }.margin(1)
      s.assert == " ABC\n 123\n TEST"
    end

    test "spacing" do
      s = %q{
            |ABC
            |123
            |TEST
            }.margin(2)
      s.assert == "  ABC\n  123\n  TEST"
    end

    test "spacing" do
      s = %q{ ABC
            - 123
            - TEST
            }.margin
      s.assert == " ABC\n 123\n TEST"
    end

    test "random placement" do
      volly = {}
      100.times{ |n|
        k = []
        a = []
        5.times{ |i|
          k << ( ( ' ' * Integer(rand*10) ) + '|' + i.to_s )
          a << ( i.to_s )
        }
        volly[k.join("\n")] = a.join("\n")
      }
      volly.each{ |k,v|
        k.margin.assert == v
      }
    end

  end

end
