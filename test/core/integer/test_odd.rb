Covers 'facets/integer/odd'

# NOTE: Can't test on Integer directly b/c Ruby 1.8.7 defines separate
# methods for Fixnum.
Case Fixnum do

  Unit :odd? do
    (-101..101).step(2) do |n|
      n.odd?.assert == true
    end
    (-100..100).step(2) do |n|
      n.odd?.assert == false
    end
  end

end

