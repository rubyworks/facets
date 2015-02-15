covers 'facets/numeric/round_to'

test_case Numeric do

  f0 = [ 0, 10, 15, 105 ]

  # method :round_at do
  #
  #   test "1" do
  #     fr = f0.collect{ |f| f.round_at(1) }
  #     fr.assert == [0,10,15,105]
  #   end
  #
  #   test "2" do
  #     fr = f0.collect { |f| f.round_at(2) }
  #     fr.assert == [0,10,15,105]
  #   end
  #
  # end

  method :round_to do

    test "0.1" do
      fr = f0.collect { |f| f.round_to(0.1) }
      fr.assert == [0,10,15,105]
    end

    test "10" do
      fr = f0.collect { |f| f.round_to(10) }
      fr.assert == [0,10,20,110]
    end

  end

  #method :round_off do
  #  test do
  #    1.2.round_off.assert == 1.0
  #    1.8.round_off.assert == 2.0
  #  end
  #end

end

test_case Float do

  f1 = [ 10.1, 10.01, 10.9, 10.09, 10.5, 10.05, 10.49 ]

  # method :round_at do
  #
  #   test "1" do
  #     fr = f1.collect { |f| f.round_at(1) }
  #     fr.assert == [10.1,10.0,10.9,10.1,10.5,10.1,10.5]
  #   end
  #
  #   test "2" do
  #     fr = f1.collect { |f| f.round_at(2) }
  #     fr.assert == [10.1,10.01,10.9,10.09,10.5,10.05,10.49]
  #   end
  #
  # end

  method :round_to do

    test "0.1" do
      fr = f1.collect { |f| f.round_to(0.1) }
      fr.assert == [10.1,10.0,10.9,10.1,10.5,10.1,10.5]
    end

    test "10" do
      fr = f1.collect { |f| f.round_to(10) }
      fr.assert == [10,10,10,10,10,10,10]
    end

  end

end
