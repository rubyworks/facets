## MatchData#matchtree

    require 'facets/matchdata/matchtree'

    md = /(bb)(cc(dd))(ee)/.match "XXaabbccddeeffXX"
    md.matchtree.assert == [["bb"], ["cc", ["dd"]], ["ee"]]

    md = /(bb)c(c(dd))(ee)/.match "XXaabbccddeeffXX"
    md.matchtree.assert == [["bb"], "c", ["c", ["dd"]], ["ee"]]

