covers 'facets/regexp/op_add'

test_case Regexp do

  method :+ do

    test do
      r = /a/ + /b/
      r.assert == /(?-mix:a)(?-mix:b)/
    end

  end

end

