require 'facets/enumerable/none'

Case Enumerable do

  Unit :none? do
    a = [nil, nil]
    assert( a.none? )

    a = [false, false]
    assert( a.none? )

    a = [true, false]
    assert( ! a.none? )

    a = [nil, 1]
    assert( ! a.none? )
  end

end
