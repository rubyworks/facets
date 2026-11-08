covers 'facets/enumerable/defer'

test_case Enumerable do

  method :defer do

    test "without a block, it is lazy" do
      r = (1..Float::INFINITY).defer.select { |i| i.even? }.map { |i| i + 100 }.first(3)
      r.assert == [102, 104, 106]
    end

    test "with a block, the block filters into the output" do
      r = (1..10).defer { |out, i| out << i if i.even? }.first(5)
      r.assert == [2, 4, 6, 8, 10]
    end

    test "with a block, chained" do
      r = (1..Float::INFINITY).
            defer { |out, i| out << i if i % 2 == 0 }.
            defer { |out, i| out << i + 100 }.
            first(3)
      r.assert == [102, 104, 106]
    end

    test "warns that it's deprecated" do
      warnings = WarningRecorder.record { [1].defer }
      warnings.size.assert == 1
      warnings.first.assert =~ /lazy/
    end

  end

end
