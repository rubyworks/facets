covers 'facets/string/cmp'

testcase String do

  unit :cmp => 'on strings' do
    "abc".cmp("abc").assert == 0
    "abc".cmp("abcd").assert == -1
    "abcd".cmp("abc").assert ==  1
    "abc".cmp("bcd").assert == -1
    "bcd".cmp("abc").assert ==  1
  end

end

