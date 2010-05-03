require 'facets/string/op_sub'

Case String do

  Unit :"-" do
    s = "xxbooxxfoo"
    (s - "xx").assert == "boofoo"
  end

end

