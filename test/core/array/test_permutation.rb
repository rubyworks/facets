covers 'facets/array/permutation'

test_case Array do

  method :permutation do

    test do
      r = []
      %w[a b c].permutation{ |x| r << x.join('') }

      x = ['abc','acb','bac','bca','cab','cba']
      x.each do |e|
        r.assert.include?(e)
      end
    end

  end

end

