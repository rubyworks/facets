covers 'facets/enumerable/defer'

tests Enumerable do

  source = (1...1/0.0)

  unit :defer do
    Denumerator.assert === [1,2,3,4].defer
  end

  unit :defer => "without block" do
    a = source.defer
    a.class.assert == Denumerator
    a.take(5).to_a.assert == [1,2,3,4,5]
  end

  unit :defer => "with block" do
    a = source.defer { |out,i| out << i*2 }
    a.class.assert == Denumerator
    a.take(5).to_a.assert == [2,4,6,8,10]
  end

end

