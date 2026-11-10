covers 'facets/string/remove'

test_case String do

  method :remove do

    test "remove string" do
      s = "xxbooxxfoo"
      s.remove("xx").assert == "boofoo"
    end

    test "remove regex" do
      s = "xbooxxfoox"
      s.remove(/x{1,2}/).assert == "boofoo"
    end


    test "removes several patterns" do
      "foo bar".remove(/o/, "b").assert == "f ar"
    end

  end

  method :remove! do

    test "remove string" do
      s = "xxbooxxfoo"
      s.remove!("xx")
      s.assert == "boofoo"
    end

    test "remove regex" do
      s = "xbooxxfoox"
      s.remove!(/x{1,2}/)
      s.assert == "boofoo"
    end


    test "removes several patterns" do
      s = "foo bar"
      s.remove!(/o/, "b")
      s.assert == "f ar"
    end

    test "returns the string even if nothing was removed" do
      s = "foo"
      s.remove!("x").equal?(s).assert == true
    end

  end

  method :- do

    test "remove string" do
      s = "xxbooxxfoo"
      (s - "xx").assert == "boofoo"
    end

    test "remove regex" do
      s = "xbooxxfoox"
      (s - /x{1,2}/).assert == "boofoo"
    end

  end

end

