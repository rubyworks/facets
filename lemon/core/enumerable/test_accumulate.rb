require 'facets/enumerable/accumulate'

Case Enumerable do

  Unit :accumulate do
    a = [1,2,3]
    a.accumulate.succ.assert == [2,3,4]
    a.accumulate(2).succ.to_s.assert == ['2','3','4']

    a = [{:ab=>1},{22=>:c}]
    a.accumulate.values_at(:ab,22).assert == [1,nil,nil,:c]
    a.accumulate(3).keys.to_s.split(//).assert == ['a', 'b', '2','2']

    a = []
    a.accumulate.succ.assert == []
  end

end

