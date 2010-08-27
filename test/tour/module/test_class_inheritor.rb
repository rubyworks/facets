covers 'facets/module/class_inheritor'

tests Class do

  context "subclass with inheritor" do
    c1 = Class.new do
      class_inheritor :koko, [], :+
      koko! << 1
    end
    c2 = Class.new(c1) do
      class_inheritor :koko, [], :+
      koko! << 2
    end
    [c1,c2]
  end

  unit :class_inheritor do |c|
    c1, c2 = c
    c1.koko!.assert == [1]
    c1.koko.assert  == [1]
    c2.koko!.assert == [2]
    c2.koko.assert  == [1,2]
  end

  context "subclass without inheritor" do
    c1 = Class.new do
      class_inheritor :koko, [], :+
      koko! << 1
    end
    c2 = Class.new(c1)
    [c1,c2]
  end

  unit :class_inheritor do |c|
    c1, c2 = c
    c1.koko!.assert == [1]
    c1.koko.assert  == [1]
    c2.koko!.assert == []
    c2.koko.assert  == [1]
  end

  context "include module with inheritor" do
    c1 = Class.new do
      class_inheritor :x, {}, :merge
      x![:a] = 1
    end
    m1 = Module.new do
      class_inheritor :x, {}, :merge
      x![:b] = 2
    end
    c2 = Class.new(c1) do
      include m1
      class_inheritor :x, {}, :merge
      x![:c] = 3
    end
    [c1,m1,c2]
  end

  unit :class_inheritor do |c|
    c1, m1, c2 = c
    c1.x.assert == {:a=>1}

    m1.x[:b].assert == 2

    c2.x.assert == {:a=>1,:b=>2,:c=>3}

    c1.x[:a].assert == 1
    c1.x[:b].assert == nil
    c1.x[:c].assert == nil

    c2.x[:a].assert == 1
    c2.x[:b].assert == 2
    c2.x[:c].assert == 3
  end

  unit :class_inheritor => "" do |c|
    c1, m1, c2 = c
    c2.x![:d] = 4
    c2.x[:d].assert == 4
  end

  context "using #concat as the inheritor operator" do
    c1 = Class.new do
      class_inheritor :relations, [], :concat
    end
    c2 = Class.new(c1) do
      #class_inheritor :relations, [], :concat
    end
    c1.relations! << 1
    c1.relations! << 2
    c2.relations! << 3
    [c1,c2]
  end

  unit :class_inheritor do |c|
    c1, c2 = c
    c1.relations.assert == [1,2]
    c2.relations.assert == [1,2,3]
  end

end


tests Module do

  context "" do
    m1 = Module.new do
      class_inheritor :koko, [], :+
      koko! << 1
    end
    c1 = Class.new do
      include m1
      #inheritor :koko, [], :+
      koko! << 2
      koko! << 3
    end
    c2 = Class.new do
      include m1
      #inheritor :koko, [], :+
      koko! << 4
    end
    [m1,c1,c2]
  end

  unit :class_inheritor do |c|
    m1,c1,c2 = c
    m1.koko.assert  == [1]
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

