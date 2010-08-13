covers 'facets/array/permutation'

tests Array do

  unit :permutation do
    r = []
    %w[a b c].permutation{ |x| r << x.join('') }

    x = ['abc','acb','bac','bca','cab','cba']
    x.each do |e|
      r.assert.include?(e)
    end
  end

end

