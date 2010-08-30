covers 'facets/numeric/round'

testcase Numeric do

  f0 = [ 0, 10, 15, 105 ]

  unit :round_at => "1" do
    fr = f0.collect{ |f| f.round_at(1) }
    fr.assert == [0,10,15,105]
  end

  unit :round_at => "2" do
    fr = f0.collect { |f| f.round_at(2) }
    fr.assert == [0,10,15,105]
  end

  unit :round_to => "0.1" do
    fr = f0.collect { |f| f.round_to(0.1) }
    fr.assert == [0,10,15,105]
  end

  unit :round_to => "10" do
    fr = f0.collect { |f| f.round_to(10) }
    fr.assert == [0,10,20,110]
  end

  #unit :round_off do
  #  1.2.round_off.assert == 1.0
  #  1.8.round_off.assert == 2.0
  #end

end

testcase Float do

  f1 = [ 10.1, 10.01, 10.9, 10.09, 10.5, 10.05, 10.49 ]

  unit :round_at => "1" do
    fr = f1.collect { |f| f.round_at(1) }
    fr.assert == [10.1,10.0,10.9,10.1,10.5,10.1,10.5]
  end

  unit :round_at => "2" do
    fr = f1.collect { |f| f.round_at(2) }
    fr.assert == [10.1,10.01,10.9,10.09,10.5,10.05,10.49]
  end

  unit :round_to => "0.1" do
    fr = f1.collect { |f| f.round_to(0.1) }
    fr.assert == [10.1,10.0,10.9,10.1,10.5,10.1,10.5]
  end

  unit :round_to => "10" do
    fr = f1.collect { |f| f.round_to(10) }
    fr.assert == [10,10,10,10,10,10,10]
  end

end
