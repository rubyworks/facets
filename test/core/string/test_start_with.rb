covers 'facets/string/start_with'

test_case String do

  method :start_with? do

    test do
      s = "xxboo"
      s.assert.start_with?('xx')
    end

  end

  method :starts_with? do

    test do
      s = "xxboo"
      s.assert.starts_with?('xx')
    end

  end

end

