covers 'facets/string/titlecase'

test_case String do

  method :titlecase do

    test do
      r = "try this out".titlecase
      x = "Try This Out"
      r.assert == x
    end

  end

end

