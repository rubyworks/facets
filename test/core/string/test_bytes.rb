covers 'facets/string/bytes'

testcase String do

  unit :bytes do
    s = "abc"
    s.bytes.to_a.assert == s.unpack('C*')
  end

end

