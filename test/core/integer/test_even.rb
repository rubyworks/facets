covers 'facets/integer/even'

# NOTE: Can't test on Integer directly b/c Ruby 1.8.7 defines separate
# methods for Fixnum.
testcase Fixnum do

  unit :even? do
    (-100..100).step(2) do |n|
      n.even?.assert == true
    end
    (-101..101).step(2) do |n|
      n.even?.assert == false
    end
  end

end

