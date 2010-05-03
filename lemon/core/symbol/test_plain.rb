require 'facets/symbol/plain'

Case Symbol do

  Unit :plain? do
    assert( :try.plain? )

    assert( ! :try=.plain? )
    assert( ! :try?.plain? )
  end

end

