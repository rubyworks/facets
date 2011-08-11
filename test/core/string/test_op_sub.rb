covers 'facets/string/op_sub'

test_case String do

  method :"-" do

    test do
      s = "xxbooxxfoo"
      (s - "xx").assert == "boofoo"
    end

  end

end

