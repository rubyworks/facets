covers 'facets/enumerable/frequency'

test_case Enumerable do

  method :frequency do

    test do
      %w{a b}.frequency.assert == {'a'=>1,'b'=>1}
      %w{a a b}.frequency.assert == {'a'=>2,'b'=>1}
    end

  end

end

