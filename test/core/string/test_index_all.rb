covers 'facets/string/index_all'

test_case String do

  method :index_all do

    test do
      "axxxaxxxa".index_all('a').assert == [0,4,8]
    end

  end

end

