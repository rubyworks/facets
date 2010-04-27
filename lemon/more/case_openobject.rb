require 'hashery/openobject'

TestCase OpenObject do

  Unit :respond_to? do
    o = OpenObject.new
    assert{ o.respond_to?(:key?) }
  end

  Unit :is_a? do
    assert OpenObject[{}].is_a?(Hash)
    assert OpenObject[{}].is_a?(OpenObject)
  end

  Unit :[] => "subhash access" do
    o = OpenObject[:a=>1,:b=>{:x=>9}]
    assert{ o[:b][:x] == 9 }
    assert{ o.b[:x] == 9 }
  end

  Unit :[] => "indifferent key access" do
    o = OpenObject["a"=>1,"b"=>{:x=>9}]
    assert{ o["a"] == 1 }
    assert{ o[:a] == 1 }
    assert{ o["b"] == {:x=>9} }
    assert{ o[:b] == {:x=>9} }
    assert{ o["b"][:x] == 9 }
    assert{ o[:b]["x"] == nil }
  end

  Unit :[]= => "setting first entry" do
    f0 = OpenObject.new
    f0[:a] = 1
    assert{ f0.to_h == {:a=>1} }
  end

  Unit :[]= => "setting an additional entry" do
    f0 = OpenObject[:a=>1]
    f0[:b] = 2
    assert{ f0.to_h == {:a=>1,:b=>2} }
  end

  Unit :method_missing => "reading entries" do
    f0 = OpenObject[:class=>1]
    assert{ f0.class  == 1 }
  end

  Unit :method_missing => "setting entries" do
    fo = OpenObject.new
    9.times{ |i| fo.__send__("n#{i}=", 1) }
    9.times{ |i|
      assert( fo.__send__("n#{i}") == 1 )
    }
  end

  Unit :method_missing => "using bang" do
    o = OpenObject.new
    o.a = 10
    o.b = 20
    h = {}
    o.each!{ |k,v| h[k] = v + 10 }
    assert( h == {:a=>20, :b=>30} )
  end

  #Unit :as_hash do
  #  f0 = OpenObject[:f0=>"f0"]
  #  h0 = { :h0=>"h0" }
  #  assert{ OpenObject[:f0=>"f0", :h0=>"h0"] == f0.as_hash.merge(h0) }
  #  assert{  {:f0=>"f0", :h0=>"h0"} == h0.merge(f0) }
  #end

  Unit :as_hash do
    f1 = OpenObject[:f1=>"f1"]
    h1 = { :h1=>"h1" }
    f1.as_hash.update(h1)
    h1.update(f1)
    assert{ f1 == OpenObject[:f1=>"f1", :h1=>"h1"] }
    assert{ h1 == {:f1=>"f1", :h1=>"h1"} }
  end

  Unit :<< => "passing a hash" do
    fo = OpenObject.new
    fo << {:a=>1,:b=>2}
    assert{ fo.to_h == {:a=>1, :b=>2} }
  end

  Unit :<< => "passing a pair" do
    fo = OpenObject.new
    fo << [:a, 1]
    fo << [:b, 2]
    assert( fo.to_h == {:a=>1, :b=>2} )
  end

  Unit :to_h do
    ho = {}
    fo = OpenObject.new
    5.times{ |i| ho["n#{i}".to_sym] = 1 }
    5.times{ |i| fo.__send__("n#{i}=", 1) }
    assert{ fo.to_h == ho  }
  end

  Unit :to_h => "OpenObject within OpenObject" do
    o = OpenObject.new
    o.a = 10
    o.b = 20
    o.x = OpenObject.new
    o.x.a = 100
    o.x.b = 200
    o.x.c = 300
    assert{ o.to_h == {:a=>10, :b=>20, :x=>{:a=>100, :b=>200, :c=>300}} }
  end

  Unit :to_proc do
    p = lambda { |x| x.word = "Hello" }
    o = OpenObject[:a=>1,:b=>2]
    assert{ Proc === o.to_proc }
  end

end

TestCase Proc do

  Unit :to_openobject do
    p = lambda { |x| x.word = "Hello" }
    o = p.to_openobject
    assert{ o.word == "Hello" }
  end

end

