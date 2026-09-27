covers 'facets/string/similarity'

test_case String do

  method :similarity do

    test do
      "Alexsanders".similarity("Aleksander").round(3).assert == 0.818
    end

    test do
      "Alexander".similarity("Alexander").assert == 1.0
    end

    test do
      "Alexander".similarity("").assert == 0.0
    end

    test "9 of 10 characters shared" do
      "Alexsander".similarity("Aleksander").assert == 0.9
    end

    test "empty non-String argument" do
      "".similarity(:"").assert == 0.0
      "".similarity([]).assert == 0.0
    end

  end

end

