covers 'facets/symbol/thrown'

test_case Symbol do

  method :thrown? do

    test "throws what is expected" do
      assert( :a.thrown? { throw :a } )
    end

    test "throws something else" do
      refute( :a.thrown? { throw :b } )
    end

    test "throws nothing at all" do
      refute( :a.thrown? { } )
      refute( :a.thrown? { true } )  # to exclude block's return value usage.
    end
  end

end

