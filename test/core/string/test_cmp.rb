covers 'facets/string/cmp'

test_case String do

  method :cmp do

    test 'on strings' do
      "abc".cmp("abc").assert == 0
      "abc".cmp("abcd").assert == -1
      "abcd".cmp("abc").assert ==  1
      "abc".cmp("bcd").assert == -1
      "bcd".cmp("abc").assert ==  1
    end

  end

end

