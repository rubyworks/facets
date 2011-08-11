covers 'facets/matchdata/matchset'

test_case MatchData do

  method :matchtree do

    test do
      md = /(bb)(cc(dd))(ee)/.match "XXaabbccddeeffXX"
      md.matchtree.assert == [["bb"], ["cc", ["dd"]], ["ee"]]
    end

    test do
      md = /(bb)c(c(dd))(ee)/.match "XXaabbccddeeffXX"
      md.matchtree.assert == [["bb"], "c", ["c", ["dd"]], ["ee"]]
    end

  end

  method :matchset do

    test do
      md = /(bb)(cc(dd))(ee)/.match "XXaabbccddeeffXX"
      md.matchset.assert == ["XXaa", [["bb"], ["cc", ["dd"]], ["ee"]], "ffXX"]
    end

  end

end

