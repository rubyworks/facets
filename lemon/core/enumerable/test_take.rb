Covers 'facets/enumerable/take'

Case Enumerable do

  Unit :take => 'is finite' do
    infinite = (1..1/0.0) # infinite Enumerable
    infinite.take(5).assert == [1,2,3,4,5]
  end

end

