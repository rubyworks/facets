covers 'facets/matchdata/match'

test_case MatchData do

  method :match do

    test do
      md = /X(a)(b)(c)X/.match("YXabcXY")
      md.match.assert == "XabcX"
    end

  end

end
