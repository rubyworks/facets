Covers 'facets/enumerable/defer'

Case Enumerable do

  source = (1...1/0.0)

  Unit :defer do
    Denumerator.assert === [1,2,3,4].defer
  end

  Unit :defer => "without block" do
    a = source.defer
    a.class.assert == Denumerator
    a.take(5).to_a.assert == [1,2,3,4,5]
  end

  Unit :defer => "with block" do
    a = source.defer { |out,i| out << i*2 }
    a.class.assert == Denumerator
    a.take(5).to_a.assert == [2,4,6,8,10]
  end

end

