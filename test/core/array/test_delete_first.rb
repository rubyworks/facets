covers 'facets/array/delete_first'

test_case Array do

  method :delete_first do

    test "deletes only the first match" do
      a = ["a", "b", "b", "c"]
      a.delete_first("b").assert == "b"
      a.assert == ["a", "b", "c"]
    end

    test "returns nil if there is no match" do
      a = ["a", "b"]
      a.delete_first("z").assert == nil
      a.assert == ["a", "b"]
    end

    test "returns the block's result if there is no match" do
      ["a"].delete_first("z") { |x| "#{x} not found" }.assert == "z not found"
      ["z"].delete_first("z") { "not found" }.assert == "z"
    end

  end

end
