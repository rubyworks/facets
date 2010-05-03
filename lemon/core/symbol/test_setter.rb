require 'facets/symbol/setter'

Case Symbol do

  Unit :setter? do
    assert( :try=.setter? )

    assert( ! :try.setter? )
    assert( ! :try?.setter? )
  end

end

