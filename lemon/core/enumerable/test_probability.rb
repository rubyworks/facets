require 'facets/enumerable/probability'

Case Enumerable do

  Unit :probability do
    %w{a b}.probability.assert == {'a'=>0.5, 'b'=>0.5}
    %w{a a a b}.probability.assert == {'a'=>0.75, 'b'=>0.25}
  end

end

