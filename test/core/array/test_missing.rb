require 'facets/array/missing'

test_case Array do

	method :missing do
		test { [1,3..3].missing.assert == [2] }
		test { [1..5,10..12].missing.assert == [6..9] }
		test { [100, 9..11, 14, 1..5, 16, 10..12, 17..17].missing.assert == [6..8, 13, 15, 18..99] }
	end

end

