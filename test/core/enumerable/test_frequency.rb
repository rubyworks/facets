covers 'facets/enumerable/frequency'

testcase Enumerable do

  unit :frequency do
    %w{a b}.frequency.assert == {'a'=>1,'b'=>1}
    %w{a a b}.frequency.assert == {'a'=>2,'b'=>1}
  end

end

