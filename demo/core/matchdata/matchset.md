## MatchData#matchset

    require 'facets/matchdata/matchset'

    md = /(bb)(cc(dd))(ee)/.match "XXaabbccddeeffXX"
    md.matchset.assert == ["XXaa", [["bb"], ["cc", ["dd"]], ["ee"]], "ffXX"]

