covers 'facets/hash/weave'

test_case Hash do

  method :weave do

    test do
      b = { :a=>1, :b=>[1,2,3], :c=>{ :x=>'X' } }
      c = { :a=>2, :b=>[4,5,6], :c=>{ :x=>'A', :y => 'B' } }
      x = { :a=>2, :b=>[1,2,3,4,5,6], :c=>{ :x => 'A', :y => 'B' } }
      b.weave(c).assert == x
    end

  end

end


