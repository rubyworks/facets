## String#trim

    require 'facets/string/trim'

    s = %q{
          |ABC
          |123
          |TEST
          }.trim
    s.assert == "ABC\n123\nTEST"

    s = %q{
            |ABC
          |123
                |TEST
          }.trim
    s.assert == "ABC\n123\nTEST"

    s = %q{|ABC
          |123
          |TEST
    }.trim
    s.assert == "ABC\n123\nTEST"

    s = %q{
          |ABC
          |123
          |TEST}.trim
    s.assert == "ABC\n123\nTEST"

    s = %q{|ABC
          |123
          |TEST}.trim
    s.assert == "ABC\n123\nTEST"

    s = %q{   |ABC
          |123
          |TEST}.trim
    s.assert == "ABC\n123\nTEST"

    s = %q{ABC
          |123
          |TEST
          }.trim
    s.assert == "ABC\n123\nTEST"

spacing

    s = %q{
          | ABC
          | 123
          | TEST
          }.trim
    s.assert == " ABC\n 123\n TEST"

    s = %q{
          |ABC
          |123
          |TEST
          }.trim(1)
    s.assert == " ABC\n 123\n TEST"

    s = %q{
          |ABC
          |123
          |TEST
          }.trim(2)
    s.assert == "  ABC\n  123\n  TEST"

    s = %q{ ABC
          - 123
          - TEST
          }.trim
    s.assert == " ABC\n 123\n TEST"

random placement

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
      k.trim.assert == v
    }

