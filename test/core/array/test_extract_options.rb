covers 'facets/array/extract_options'

testcase Array do

  unit :extract_options! do
    h = { :x=>1, :y=>1 }
    a = [:a, :b, h]
    a.extract_options!.assert == h
  end

end

testcase Hash do

  unit :extractable_options? do
    h = { :x=>1, :y=>1 }
    h.assert.extractable_options?
  end

end
