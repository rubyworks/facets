require 'facets/array/arrange'

test_case Array do

	method :rangify do
		test 'Array of consecutive integers should return an array made up of a single range.' do
			[1,2,3,4,5].rangify.assert == [1..5]
		end
		
		test 'Array of non-consecutive integers should return the original array.' do
			[1,3,5,7].rangify.assert == [1,3,5,7]
		end

		test 'Array of ranges should return the correct ranges.' do
			arr = [40..45, 1..3, 4..10, 20..30, 24..28, 42..50, 1..6, 1..3, 1..1]
			arr.rangify.assert == [1..10, 20..30, 40..50]
		end
		
		test 'Array of ranges and integers should return the correct ranges.' do
			arr = [99, 100, 1..3, 101, 4..5, 103, 10..19, 99, 20..20, 31, 32..33, 98, 97]
			arr.rangify.assert == [1..5, 10..20, 31..33, 97..101, 103]
		end	

		test 'Array of non-consecutive integers should return the correct ranges.' do
			[1,2,3,6,7,8,10,15].rangify.assert == [1..3, 6..8, 10, 15] 
		end
	
		test 'Element order should not affect the result.' do
			[8, 1, 15, 2, 6, 3, 7, 10].rangify.assert == [1..3, 6..8, 10, 15] 
		end
		
		test 'Duplicate elements should not affect the result.' do
			[8, 1, 15, 2, 6, 3, 7, 10, 8, 15, 2, 3, 1, 2].rangify.assert == [1..3, 6..8, 10, 15] 
		end
	end

end
