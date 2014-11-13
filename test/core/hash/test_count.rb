covers 'facets/hash/count'

test_case Hash do

  method :count do

    test do
      {:A=>1, :B=>1, :C=>2}.count(1).assert == 2
      {:A=>1, :B=>1, :C=>2}.count(2).assert == 1
    end

    test "no matches" do
      {:A=>1, :B=>1, :C=>2}.count(3).assert == 0
    end

    test "still works with Enumerable#count" do
      {:A=>1, :B=>1, :C=>2}.count.assert == 3
    end

  end

end

