require 'facets/string/bytes'

Case String do

  Unit :bytes do
    s = "abc"
    s.bytes.to_a.assert == s.unpack('C*')
  end

end

