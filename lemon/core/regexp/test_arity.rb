Covers 'facets/regexp/arity'

Case Regexp do

  Unit :arity do
    r = /(1)(2)(3)/
    r.arity.assert == 3

    r = /(1)(2)(3)(4)/
    r.arity.assert == 4

    r = /(1)(2)((a)3)/
    r.arity.assert == 4

    r = /(?#nothing)(1)(2)(3)(?=3)/
    r.arity.assert == 3
  end

end

