covers 'facets/string/quote'

testcase String do

  unit :quote => "counting quotes" do
    'hi'.quote(1).assert == %{'hi'}
    'hi'.quote(2).assert == %{"hi"}
    'hi'.quote(3).assert == %{'"hi"'}
    'hi'.quote(4).assert == %{""hi""}
    'hi'.quote(5).assert == %{'""hi""'}
  end

  unit :quote => "default double quotes" do
    'hi'.quote.assert == %{"hi"}
  end

  unit :quote => "single quotes" do
    'hi'.quote(:s).assert == %{'hi'}
    'hi'.quote(:single).assert == %{'hi'}
  end

  unit :quote => "double quotes" do
    'hi'.quote(:d).assert == %{"hi"}
    'hi'.quote(:double).assert == %{"hi"}
  end

  unit :quote => "back quotes" do
    'hi'.quote(:b).assert == %{`hi`}
    'hi'.quote(:back).assert == %{`hi`}
  end

  unit :quote => "bracket quotes" do
    'hi'.quote(:sb).assert == "`hi'"
    'hi'.quote(:bracket).assert == "`hi'"
  end

end

