require 'facets/enumerable/occur'

Case Enumerable do

  Unit :occur do
    arr = [:a,:b,:a]
    arr.occur(1).assert == [:b]
    arr.occur(2).assert == [:a]
    arr.occur(1..1).assert == [:b]
    arr.occur{ |n| n % 2 == 0 }.assert == [:a]
  end

end

