covers 'facets/hash/count'

test_case Hash do

  method :count do

    test do
      {:A=>1, :B=>1}.count(1).assert == 2
    end

  end

end

