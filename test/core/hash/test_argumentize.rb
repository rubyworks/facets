covers 'facets/hash/argumentize'

test_case Hash do

  method :argumentize do

    setup do
      @h = { :list => [1,2], :base => "HI" }
    end

    test "without an argument field" do
      @h.argumentize.assert == [ { :list => [1,2], :base => "HI" } ]
    end

    test "with an argument field" do
      @h.argumentize(:list).assert == [ 1, 2, { :base => "HI" } ]
      @h.argumentize(:base).assert == [ "HI", { :list => [1,2] } ]
    end

  end

end

