Covers 'facets/enumerable/inject'

Case Enumerable do

  Unit :inject! do
    r = [1,2,3,4,5].inject!([]){ |a,i| a << i % 2 }
    e = [1,0,1,0,1]
    r.assert == e
  end

  Unit :inject! => "empty enumerable" do
    r = [].inject!([]){ |a,i| a << i % 2 }
    e = []
    r.assert == e
  end

end
