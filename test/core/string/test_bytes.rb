covers 'facets/string/bytes'

test_case String do

  method :bytes do
    test do
      s = "abc"
      s.bytes.to_a.assert == s.unpack('C*')
    end
  end

end

