require 'facets/string/splice'

Case String do

  Unit :splice do
    a = "HELLO"
    a.splice(1).assert == "E"
    a.assert == "HLLO"
  end

  # This could be done if class of 2nd arg is checked.
  #Unit :splice_length
  #  a = "HELLO"
  #  a.splice(1,2).assert == "EL"
  #  a.assert == "HLO"
  #end

  Unit :splice => "range" do
    a = "HELLO"
    a.splice(1..2).assert == "EL"
    a.assert == "HLO"
  end

  Unit :splice => "store" do
    a = "HELLO"
    a.splice(1, "X")
    a.assert == "HXLLO"
  end

end

