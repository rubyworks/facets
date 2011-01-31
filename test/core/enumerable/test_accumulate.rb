covers 'facets/enumerable/accumulate'

testcase Enumerable do

  unit :accumulate do
    a = [1,2,3]
    a.accumulate.succ.assert == [2,3,4]
  end

  unit :accumulate do
    a = [{:ab=>1},{22=>:c}]
    a.accumulate.values_at(:ab,22).assert == [1,nil,:c]
  end

  unit :accumulate => "chained twice" do
    a = [1,2,3]
    a.accumulate(2).succ.to_s.assert == ['2','3','4']
  end

  unit :accumulate => "chained three times" do
    a = [{:ab=>1},{22=>:c}]
    a.accumulate(3).keys.to_s.split(//).assert == ['a', 'b', '2']
  end

  unit :accumulate => "empty receiver" do
    a = []
    a.accumulate.succ.assert == []
  end

  unit :accumulate_all => "not uniq entries" do
    a = [{:ab=>1},{22=>:c}]
    a.accumulate_all(3).keys.to_s.split(//).assert == ['a', 'b', '2', '2']
  end

end

