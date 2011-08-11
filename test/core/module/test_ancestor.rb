covers 'facets/module/ancestor'

test_case Module do

  method :ancestor? do

    test do
      c1 = Class.new
      c2 = Class.new(c1)
      c2.assert.ancestor?(c1)
    end

  end

end

