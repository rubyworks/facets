Covers 'facets/integer/odd'

Case Integer do

  Unit :odd? do
    (-101..101).step(2) do |n|
      n.odd?.assert == true
    end
    (-100..100).step(2) do |n|
      n.odd?.assert == false
    end
  end

end

