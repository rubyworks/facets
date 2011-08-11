covers 'facets/class/descendants'

test_case Class do

  method :descendants do

    a = Class.new
    b = Class.new(a)
    c = Class.new(b)

    test do
      a.descendants.assert.include?(b)
      a.descendants.assert.include?(c)
    end

  end

end

