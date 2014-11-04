require 'facets/range/op_sub'

test_case Range do

  method :- do
    #test { lambda{ (1..10) - 'a' }.assert raise_error }

    test { ((1..10) - (5..5)).assert == [1..4, 6..10] }
		test { ((1..10) - 2).assert == [1, 3..10] }
		test { ((1..10) - 9).assert == [1..8, 10] }
		test { ((1..10) - 10).assert == [1..9, nil] }
		test { ((1..10) - 1).assert == [nil, 2..10] }
		test { ((1..10) - 11).assert == [1..10, nil] }
		test { ((1..10) - 12).assert == [1..10, nil] }
		test { ((1..10) - 0).assert == [nil, 1..10] }
		test { ((1..10) - -1).assert == [nil, 1..10] }

    test { ((1..10) - (4..6)).assert == [1..3, 7..10] }
    test { ((1..10) - (2..6)).assert == [1, 7..10] }
    test { ((1..10) - (4..9)).assert == [1..3, 10] }
    test { ((1..10) - (2..9)).assert == [1, 10] }
    test { ((1..10) - (2..11)).assert == [1] }
    test { ((1..10) - (0..9)).assert == [10] }
    test { ((1..10) - (4..10)).assert == [1..3] }
    test { ((1..10) - (4..12)).assert == [1..3] }
    test { ((1..10) - (1..6)).assert == [7..10] }
    test { ((1..10) - (-2..6)).assert == [7..10] }
    test { ((1..10) - (11..20)).assert == [1..10] }
    test { ((1..10) - (-10..0)).assert == [1..10] }
    test { ((1..10) - (-10..20)).assert == [] }
	end
	
end

