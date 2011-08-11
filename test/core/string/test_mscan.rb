covers 'facets/string/mscan'

test_case String do

  method :mscan do

    test do
      r = 'abc,def,gh'.mscan(/[,]/)
      assert( r.all?{ |md| MatchData === md } )
      r.to_a.length.assert == 2
      r[0][0].assert == ','
      r[1][0].assert == ','
    end

  end

end

