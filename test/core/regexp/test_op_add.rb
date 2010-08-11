covers 'facets/regexp/op_add'

tests Regexp do

  unit :+ do
    r = /a/ + /b/
    r.assert == /(?-mix:a)(?-mix:b)/
  end

end

