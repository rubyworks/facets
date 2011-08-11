covers 'facets/string/end_with'

test_case String do

  method :end_with? do

    test do
      s = "xxboo"
      s.assert.end_with?('boo')
    end
  
  end

  method :ends_with? do

    test do
      s = "xxboo"
      s.assert.ends_with?('boo')
    end

  end

end

