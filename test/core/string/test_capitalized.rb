covers 'facets/string/capitalized'

test_case String do

  method :capitalized? do
    test do
      'Abc'.assert.capitalized?
    end
  end

  method :downcase? do
    test do
      'abc'.assert.downcase?
    end
  end

  method :upcase? do
    test do
      'ABC'.assert.upcase?
    end
  end

  #method :lowercase? do
  #  test do
  #    'abc'.assert.lowercase?
  #  end
  #end

  #method :uppercase? do
  #  test do
  #    'ABC'.assert.uppercase?
  #  end
  #end

end

