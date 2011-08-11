covers 'facets/string/similarity'

test_case String do

  method :similarity do

    test do
      "Alexsander".similarity("Aleksander").assert == 0.9
    end

  end

end

