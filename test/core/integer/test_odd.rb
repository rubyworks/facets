covers 'facets/integer/odd'

# NOTE: Can't test on Integer directly b/c Ruby 1.8.7 defines separate
# methods for Fixnum. (huh?)
test_case Fixnum do

  method :odd? do

    test "odd numbers are odd" do
      (-101..101).step(2) do |n|
        n.odd?.assert == true
      end
    end

    test "odd numbers are not even" do
      (-100..100).step(2) do |n|
        n.odd?.assert == false
      end
    end

  end

end

