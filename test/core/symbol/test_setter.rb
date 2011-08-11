covers 'facets/symbol/setter'

test_case Symbol do

  method :setter? do
    test do
      assert( :try=.setter? )
    end

    test do
      assert( ! :try.setter? )
      assert( ! :try?.setter? )
    end
  end

end

