covers 'facets/string/unbracket'

test_case String do

  method :unbracket do

    test do
      s = "{unwrap me}"
      z = s.unbracket('{')
      z.assert == "unwrap me"
    end

    test do
      s = "--unwrap me!"
      z = s.unbracket('--','!')
      z.assert == "unwrap me"
    end

  end

  method :unbracket! do

    test do
      s = "{unwrap me}"
      s.unbracket!('{')
      s.assert == "unwrap me"
    end

    test do
      s = "--unwrap me!"
      s.unbracket!('--','!')
      s.assert == "unwrap me"
    end

  end

end

