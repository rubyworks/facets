covers 'facets/string/quote'

test_case String do

  method :quote do

    test "counting quotes" do
      'hi'.quote(1).assert == %{'hi'}
      'hi'.quote(2).assert == %{"hi"}
      'hi'.quote(3).assert == %{'"hi"'}
      'hi'.quote(4).assert == %{""hi""}
      'hi'.quote(5).assert == %{'""hi""'}
    end

    test "default double quotes" do
      'hi'.quote.assert == %{"hi"}
    end

    test "single quotes" do
      'hi'.quote(:s).assert == %{'hi'}
      'hi'.quote(:single).assert == %{'hi'}
    end

    test "double quotes" do
      'hi'.quote(:d).assert == %{"hi"}
      'hi'.quote(:double).assert == %{"hi"}
    end

    test "back quotes" do
      'hi'.quote(:b).assert == %{`hi`}
      'hi'.quote(:back).assert == %{`hi`}
    end

    test "bracket quotes" do
      'hi'.quote(:sb).assert == "`hi'"
      'hi'.quote(:bracket).assert == "`hi'"
    end

  end

end
