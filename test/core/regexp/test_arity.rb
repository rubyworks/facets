covers 'facets/regexp/arity'

test_case Regexp do

  method :arity do

    test do
      r = /(1)(2)(3)/
      r.arity.assert == 3
    end

    test do
      r = /(1)(2)(3)(4)/
      r.arity.assert == 4
    end

    test do
      r = /(1)(2)((a)3)/
      r.arity.assert == 4
    end

    test do
      r = /(?#nothing)(1)(2)(3)(?=3)/
      r.arity.assert == 3
    end

  end

end

