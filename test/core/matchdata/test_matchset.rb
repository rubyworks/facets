covers 'facets/matchdata/matchset'

testcase MatchData do

  unit :matchtree do
    md = /(bb)(cc(dd))(ee)/.match "XXaabbccddeeffXX"
    md.matchtree.assert == [["bb"], ["cc", ["dd"]], ["ee"]]

    md = /(bb)c(c(dd))(ee)/.match "XXaabbccddeeffXX"
    md.matchtree.assert == [["bb"], "c", ["c", ["dd"]], ["ee"]]
  end

  unit :matchset do
    md = /(bb)(cc(dd))(ee)/.match "XXaabbccddeeffXX"
    md.matchset.assert == ["XXaa", [["bb"], ["cc", ["dd"]], ["ee"]], "ffXX"]
  end

end

