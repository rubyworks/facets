covers 'facets/enumerable/defer'

test_case Enumerable do

  method :defer do

    source = (1...1/0.0)

    test do
      Denumerator.assert === [1,2,3,4].defer
    end

    test "without block" do
      a = source.defer
      a.class.assert == Denumerator
      a.take(5).to_a.assert == [1,2,3,4,5]
    end

    test "with block" do
      a = source.defer { |out,i| out << i*2 }
      a.class.assert == Denumerator
      a.take(5).to_a.assert == [2,4,6,8,10]
    end

  end

end
