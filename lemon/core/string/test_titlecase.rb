Covers 'facets/string/titlecase'

Case String do

  Unit :titlecase do
    r = "try this out".titlecase
    x = "Try This Out"
    r.assert == x
  end

end

