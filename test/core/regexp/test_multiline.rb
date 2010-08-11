covers 'facets/regexp/multiline'

tests Regexp do

  unit :multiline? do
    re = /x/m
    re.assert.multiline?
  end

  unit :multiline? do
    re = /x/
    re.refute.multiline?
  end

end
