require 'hashery/stash'

TestCase Stash do

  Unit :[] => 'class level fetch' do
    s = Stash[:a=>1, :b=>2]
    assert(s)
  end

  Unit :[] => 'instance level fetch' do
    s = Stash[:a=>1, :b=>2]
    s[:a].assert == 1
    s[:b].assert == 2
    s['a'].assert == 1
    s['b'].assert == 2
  end

  Unit :[]= => '' do
    s = Stash.new
    s[:a] = 1
    s[:b] = 2
    s[:a].assert == 1
    s[:b].assert == 2
    s['a'].assert == 1
    s['b'].assert == 2
  end

  Unit :initialize do
    s = Stash.new
    assert(s)
  end

  Unit :to_hash do
    s = Stash[:a=>1, :b=>2]
    s.to_hash.assert == {'a'=>1, 'b'=>2}
  end

  Unit :to_h do
    s = Stash[:a=>1, :b=>2]
    s.to_h.assert == {'a'=>1, 'b'=>2}
  end

  Unit :replace do
    s = Stash.new
    s.replace(:a=>1, :b=>2)
    s.to_h.assert == {'a'=>1, 'b'=>2}
  end

  Unit :delete do
    s = Stash[:a=>1, :b=>2]
    s.delete(:a)
    s.to_h.assert == {'b'=>2}
  end

  Unit :each do
    s = Stash[:a=>1, :b=>2]
    s.each do |k,v|
      String.assert === k
    end
  end

  Unit :store => '' do
    s = Stash.new
    s.store(:a, 1)
    s.to_h.assert == {'a'=>1}
  end

  Unit :update => '' do
    s1 = Stash[:a=>1,:b=>2]
    s2 = Stash[:c=>3,:d=>4]
    s1.update(s2)
    s1.to_h.assert == {'a'=>1,'b'=>2,'c'=>3,'d'=>4}
  end

  Unit :rekey => '' do
    s = Stash[:a=>1,:b=>2,:c=>3]
    x = s.rekey{ |k| k.upcase }
    x.to_h.assert == {'A'=>1,'B'=>2,'C'=>3}
  end

  Unit :rekey! => '' do
    s = Stash[:a=>1,:b=>2,:c=>3]
    s.rekey!{ |k| k.upcase }
    s.to_h.assert == {'A'=>1,'B'=>2,'C'=>3}
  end

  Unit :key? => '' do
    s = Stash[:a=>1]
    s.assert.key?(:a)
    s.assert.key?('a')
  end

  Unit :has_key? => '' do
    s = Stash[:a=>1]
    s.assert.has_key?(:a)
    s.assert.has_key?('a')
  end

  Unit :<< => '' do
    s = Stash.new
    s << [:a, 1]
    s << [:b, 2]
    s.to_h.assert == {'a'=>1, 'b'=>2}
  end

  Unit :merge! => '' do
    s1 = Stash[:a=>1,:b=>2]
    s2 = Stash[:c=>3,:d=>4]
    s1.merge!(s2)
    s1.to_h.assert == {'a'=>1,'b'=>2,'c'=>3,'d'=>4}
  end

  Unit :values_at => '' do
    s = Stash[:a=>1,:b=>2,:c=>3]
    s.values_at(:a, :b).assert == [1,2]
    s.values_at('a','b').assert == [1,2]
  end

  Unit :fetch => '' do
    s = Stash[:a=>1,:b=>2,:c=>3]
    s.fetch(:a).assert == 1
    s.fetch('a').assert == 1
  end

  Unit :convert_key => '' do
    s = Stash.new
    s.pry.convert_key(:a).assert == 'a'
  end

end

