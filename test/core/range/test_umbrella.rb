covers 'facets/range/umbrella'

test_case Range do

  method :umbrella do

    test do
      (3..6).umbrella(3..6).assert == [0,0]
      (3...6).umbrella(3...6).assert == [0,0]
    end

    test "partially aligned" do
      (3..6).umbrella(2..6).assert == [1,0]
      (3..6).umbrella(3..7).assert == [0,1]
      (3..6).umbrella(4..6).assert == [-1,0]
      (3..6).umbrella(3..5).assert == [0,-1]
    end

    test "offset" do
      (3..6).umbrella(2..7).assert == [1,1]
      (3..6).umbrella(4..7).assert == [-1,1]
      (3..6).umbrella(2..5).assert == [1,-1]
      (3..6).umbrella(4..5).assert == [-1,-1]
    end

    test "offset by exclusion" do
      (10...20).umbrella(10..20).assert == [0,1]
    end

  end

end
