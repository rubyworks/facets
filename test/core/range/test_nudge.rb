covers 'facets/range/nudge'

test_case Range do
  method :nudge do
    test 'default nudge' do
      (17..32).nudge.assert == (18..33)
      (17..32).nudge.nudge.assert == (19..34)
      (17...32).nudge.assert == (18...33)
    end

    test 'positive nudge' do
      (1..9).nudge(2).assert == (3..11)
      (1...9).nudge(2).assert == (3...11)
    end

    test 'negative nudge' do
      (5..6).nudge(-2).assert == (3..4)
      (5...6).nudge(-2).assert == (3...4)
    end

    test 'min nudge' do
      (5..9).nudge(:min => 2).assert == (7..9)
      (5...9).nudge(:min => 2).assert == (7...9)
    end

    test 'max nudge' do
      (8..16).nudge(:max => 10).assert == (8..26)
      (8...16).nudge(:max => 10).assert == (8...26)
    end
  end
end

