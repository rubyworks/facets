covers 'facets/string/index_all'

test_case String do

  method :index_all do

    test "with string argument" do
      "axxxaxxxa".index_all('a').assert == [0,4,8]
    end

    test "with regexp argument" do
      "a123a567a9".index_all(/a/).assert == [0,4,8]
    end

    test "with resue flag as true" do
      "bbb".index_all('bb', false).assert == ([0])
      "bbb".index_all('bb', true).assert == ([0,1])
    end
  end

end

