require 'facets/range/op_add'

test_case Range do

	method :+ do
    #test { lambda{ (1..10) + 'a' }.assert raise_error }

    test { ((1..10) + (11..11)).assert == [1..11] }
    test { ((1..10) + 12).assert == [1..10, 12] }
    test { ((1..10) + (10..12)).assert == [1..12] }
    test { ((1..10) + (11..12)).assert == [1..12] }
    test { ((1..10) + (9..12)).assert == [1..12] }
    test { ((1..10) + (1..12)).assert == [1..12] }
    test { ((1..10) + (12..20)).assert == [1..10, 12..20] }
    test { ((1..10) + 0).assert == [0..10] }
    test { ((1..10) + -1).assert == [-1, 1..10] }
    test { ((1..10) + (-10..-1)).assert == [-10..-1, 1..10] }
    test { ((1..10) + (-10..0)).assert == [-10..10] }
    test { ((1..10) + (-10..1)).assert == [-10..10] }
    test { ((1..10) + (-10..2)).assert == [-10..10] }
    test { ((1..10) + (-10..20)).assert == [-10..20]}
  end

end
