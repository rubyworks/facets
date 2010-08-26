Covers 'facets/inheritor.rb'

TestCase Class do

  Context "subclass with inheritor" do
    c = Class.new do
      inheritor :koko, [], :+
      koko! << 1
    end
    d = Class.new(c) do
      inheritor :koko, [], :+
      koko! << 2
    end
    [c,d]
  end

  Unit :inheritor do |c,d|
    c.koko!.assert == [1]
    c.koko.assert  == [1]
    d.koko!.assert == [2]
    d.koko.assert  == [1,2]
  end

  Context "subclass without inheritor" do
    c = Class.new do
      inheritor :koko, [], :+
      koko! << 1
    end
    d = Class.new(c)
    [c,d]
  end

  Unit :inheritor do |c,d|
    c.koko!.assert == [1]
    c.koko.assert  == [1]
    d.koko!.assert == []
    d.koko.assert  == [1]
  end

  Context "include module with inheritor" do
    c = Class.new do
      inheritor :x, {}, :merge
      x![:a] = 1
    end
    m = Module.new do
      inheritor :x, {}, :merge
      x![:b] = 2
    end
    d = Class.new(c) do
      include m
      inheritor :x, {}, :merge
      x![:c] = 3
    end
    [c,m,d]
  end

  Unit :inheritor do |c,m,d|
    c.x.assert == {:a=>1}

    m.x[:b].assert == 2

    d.x.assert == {:a=>1,:b=>2,:c=>3}

    c.x[:a].assert == 1
    c.x[:b].assert == nil
    c.x[:c].assert == nil

    d.x[:a].assert == 1
    d.x[:b].assert == 2
    d.x[:c].assert == 3
  end

  Unit :inheritor => "" do |c,m,d|
    d.x![:d] = 4
    d.x[:d].assert == 4
  end

  Context "using #concat as the inheritor operator" do
    c = Class.new do
      inheritor :relations, [], :concat
    end
    d = Class.new(c) do
      #inheritor :relations, [], :concat
    end
    c.relations! << 1
    c.relations! << 2
    d.relations! << 3
    [c,d]
  end

  Unit :inheritor do |c,d|
    c.relations.assert == [1,2]
    d.relations.assert == [1,2,3]
  end

end

TestCase Module do

  Context "" do
    m = Module.new do
      inheritor :koko, [], :+
      koko! << 1
    end
    c1 = Class.new do
      include m
      #inheritor :koko, [], :+
      koko! << 2
      koko! << 3
    end
    c2 = Class.new do
      include m
      #inheritor :koko, [], :+
      koko! << 4
    end
    [m,c1,c2]
  end

  Unit :inheritor do |m,c1,c2|
    m.koko.assert  == [1]
    c1.koko.assert == [1,2,3]
    c2.koko.assert == [1,4]
  end

  Context "" do
    m = Module.new do
      copy_inheritor :koko, []
      koko << 1
    end
    c1 = Class.new do
      include m
      #inheritor :koko, [], :+
      koko << 2
      koko << 3
    end
    c2 = Class.new do
      include m
      #inheritor :koko, [], :+
      koko << 4
    end
    [m,c1,c2]
  end

  Unit :copy_inheritor do |m,c1,c2|
    m.koko.assert  == [1]
    c1.koko.assert == [1,2,3]
    c2.koko.assert == [1,4]
  end

end

=begin
TestCase Inheritor do
  Instance "" do
    a = [1]
    Inheritor.new(a, [2], :+)
  end
  unit :== do |i|
    i.assert == [2]
  end
  unit :inheritance do |i|
    i.inheritance == [1,2]
  end
end
=end

