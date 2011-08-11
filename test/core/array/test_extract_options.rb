covers 'facets/array/extract_options'

test_case Array do

  method :extract_options! do

    test do
      h = { :x=>1, :y=>1 }
      a = [:a, :b, h]
      a.extract_options!.assert == h
    end

  end

end

test_case Hash do

  method :extractable_options? do

    test do
      h = { :x=>1, :y=>1 }
      h.assert.extractable_options?
    end

  end

end
