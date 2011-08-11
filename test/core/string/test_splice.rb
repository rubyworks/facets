covers 'facets/string/splice'

test_case String do

  method :splice do

    test do
      a = "HELLO"
      a.splice(1).assert == "E"
      a.assert == "HLLO"
    end

    test "range" do
      a = "HELLO"
      a.splice(1..2).assert == "EL"
      a.assert == "HLO"
    end

    test "store" do
      a = "HELLO"
      a.splice(1, "X")
      a.assert == "HXLLO"
    end

  end

  # This could be done if class of 2nd arg is checked.
  #method :splice_length
  #  test do
  #    a = "HELLO"
  #    a.splice(1,2).assert == "EL"
  #    a.assert == "HLO"
  #  end
  #end

end

