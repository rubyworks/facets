covers 'facets/numeric/delimit'

test_case Numeric do

  f0 = [ 0, 100, 1_000, 1_000_000 ]

  method :delimit do

    test "commas are default" do
      fr = f0.map { |f| f.delimit }
      fr.assert == %w( 0 100 1,000 1,000,000 )
    end

    test "delimiter can be anything" do
      fr = f0.map { |f| f.delimit(:delimiter => "_") }
      fr.assert == %w( 0 100 1_000 1_000_000 )
    end

    test "separator defaults to dot" do
      fr = f0.map { |f| ( f + 0.1 ).delimit }
      fr.assert == %w( 0.1 100.1 1,000.1 1,000,000.1 )
    end

    test "separator can be anything" do
      fr = f0.map { |f| ( f + 0.1 ).delimit(:separator => "!") }
      fr.assert == %w( 0!1 100!1 1,000!1 1,000,000!1 )
    end


  end

end

=begin
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
=end
