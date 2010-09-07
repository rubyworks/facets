covers 'facets/hash/argumentize'

testcase Hash do

  setup do
    { :list => [1,2], :base => "HI" }
  end

  unit :argumentize => "without an argument field" do |h|
    h.argumentize.assert == [ { :list => [1,2], :base => "HI" } ]
  end

  unit :argumentize => "with an argument field" do |h|
    h.argumentize(:list).assert == [ 1, 2, { :base => "HI" } ]
    h.argumentize(:base).assert == [ "HI", { :list => [1,2] } ]
  end

end

