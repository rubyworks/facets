covers 'facets/hash/count'

test_case Hash do

  method :count do

    test "counts key-value pairs, as Ruby's own does" do
      {:A=>1, :B=>1, :C=>2}.count([:A, 1]).assert == 1
      {:A=>1, :B=>1, :C=>2}.count([:A, 2]).assert == 0
    end

    test "with no argument" do
      {:A=>1, :B=>1, :C=>2}.count.assert == 3
    end

    test "with a block" do
      {:A=>1, :B=>1, :C=>2}.count { |k, v| v == 1 }.assert == 2
    end

    test "a value that can't be a pair counts nothing, and warns" do
      result = nil
      warnings = WarningRecorder.record { result = {:A=>1, :B=>1}.count(1) }
      result.assert == 0
      warnings.size.assert == 1
      warnings.first.assert =~ /values\.count/
    end

    test "a pair doesn't warn" do
      WarningRecorder.record { {:A=>1}.count([:A, 1]) }.assert == []
    end

  end

end
