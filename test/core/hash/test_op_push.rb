Covers 'facets/hash/op_push'

Case Hash do

  Unit :<< => "two element array" do
    h = {}
    a = [:b, 2]
    x = {:b => 2}
    (h << a).assert == h
    h.assert == x
  end

  Unit :<< => "update new entries" do
    a = {:a => 1}
    b = {:b => 2, :c => 3 }
    x = {:a => 1, :b => 2, :c => 3}
    (a << b).assert == x
    a.assert == x
  end

  Unit :<< => "update overwrite" do
    a = {:a => 1, :b => 2, :c => 3}
    b = {:a => 0, :d => 4}
    x = {:a => 0, :b => 2, :c => 3, :d => 4}
    (a << b).assert == x 
    a.assert == x
  end

end

