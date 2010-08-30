covers 'facets/regexp/to_re'

testcase Regexp do

  unit :to_re do
    r = /0..10/
    r.to_re.assert == r.to_re
  end

  unit :to_regexp do
    r = /0..10/
    r.to_regexp.assert == r
  end

end

