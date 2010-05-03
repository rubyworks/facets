require 'facets/string/mscan'

Case String do

  Unit :mscan do
    r = 'abc,def,gh'.mscan(/[,]/)
    assert( r.all?{ |md| MatchData === md } )
    r.to_a.length.assert == 2
    r[0][0].assert == ','
    r[1][0].assert == ','
  end

end

