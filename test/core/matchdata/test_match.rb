Covers 'facets/matchdata/match'

Case MatchData do

  Unit :match do
    md = /X(a)(b)(c)X/.match("YXabcXY")
    md.match.assert == "XabcX"
  end

end
