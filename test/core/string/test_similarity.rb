covers 'facets/string/similarity'

test_case String do

  method :similarity do

    test do
      "Alexsander".similarity("Aleksander").assert == 0.9
    end

    test do
      "Alexander".similarity("Alexander").assert == 1.0
    end

    test do
      "Alexander".similarity("").assert == 0.0
    end

  end

end

