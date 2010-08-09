Covers 'facets/comparable/cmp'

Case Comparable do

  Unit :cmp => 'on integers' do
    3.cmp(4).assert == -1
    3.cmp(3).assert ==  0
    3.cmp(2).assert ==  1
  end

  Unit :cmp => 'on strings' do
    "abc".cmp("abc").assert == 0
    "abc".cmp("abcd").assert == -1
    "abcd".cmp("abc").assert ==  1
    "abc".cmp("bcd").assert == -1
    "bcd".cmp("abc").assert ==  1
  end

end

