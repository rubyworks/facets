Covers 'facets/regexp/to_re'

Case Regexp do

  Unit :to_re do
    r = /0..10/
    r.to_re.assert == r.to_re
  end

  Unit :to_regexp do
    r = /0..10/
    r.to_regexp.assert == r
  end

end

