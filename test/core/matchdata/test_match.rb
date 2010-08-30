covers 'facets/matchdata/match'

testcase MatchData do

  unit :match do
    md = /X(a)(b)(c)X/.match("YXabcXY")
    md.match.assert == "XabcX"
  end

end
