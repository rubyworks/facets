covers 'facets/kernel/in'

test_case Kernel do

  method :in? do

    test do
      5.assert.in?(0..10)
      5.assert.in?([1,2,3,4,5])
    end

  end

end
