require 'facets/integer/even'

Case Integer do

  Unit :even? do
    (-100..100).step(2) do |n|
      n.even?.assert == true
    end
    (-101..101).step(2) do |n|
      n.even?.assert == false
    end
  end

end

