require 'facets/array/intersection'

test_case Array do

	method :intersection do
		test { [1, 2].intersection.assert == nil }
		test { [1..10, 11..20].intersection.assert == nil }
		test { [1..10, 5..15, 11..20].intersection.assert == nil }
		test { [8..8, 1..10, 10 ].intersection.assert == nil }
		test { [10, 1..10].intersection.assert == 10 }
		test { [1..10, 1].intersection.assert == 1 }
		test { [1, 1].intersection.assert == 1 }
		test { [1..10, 5, 5..8, 5..10 ].intersection.assert == 5 }
		test { [1..10, 5..8, 5..10 ].intersection.assert == (5..8) }
		test { [5..10, 1..10, 4..8 ].intersection.assert == (5..8) }
		test { [5..10, 1..10, 4..20, 8].intersection.assert == 8 }
	end

end
