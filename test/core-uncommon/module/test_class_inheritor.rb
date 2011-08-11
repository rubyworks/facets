covers 'facets/module/class_inheritor'

test_case Class do

  method :class_inheritor do

    test "subclass with inheritor" do
      c1 = Class.new do
        class_inheritor :koko, [], :+
        koko! << 1
      end
      c2 = Class.new(c1) do
        class_inheritor :koko, [], :+
        koko! << 2
      end

      c1.koko!.assert == [1]
      c1.koko.assert  == [1]
      c2.koko!.assert == [2]
      c2.koko.assert  == [1,2]
    end

    test "subclass without inheritor" do
      c1 = Class.new do
        class_inheritor :koko, [], :+
        koko! << 1
      end
      c2 = Class.new(c1)

      c1.koko!.assert == [1]
      c1.koko.assert  == [1]
      c2.koko!.assert == []
      c2.koko.assert  == [1]
    end

    test "include module with inheritor" do
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

      c1.x.assert == {:a=>1}

      m1.x[:b].assert == 2

      c2.x.assert == {:a=>1,:b=>2,:c=>3}

      c1.x[:a].assert == 1
      c1.x[:b].assert == nil
      c1.x[:c].assert == nil

      c2.x[:a].assert == 1
      c2.x[:b].assert == 2
      c2.x[:c].assert == 3

      c2.x![:d] = 4
      c2.x[:d].assert == 4
    end

    test "using #concat as the inheritor operator" do
      c1 = Class.new do
        class_inheritor :relations, [], :concat
      end
      c2 = Class.new(c1) do
        #class_inheritor :relations, [], :concat
      end
      c1.relations! << 1
      c1.relations! << 2
      c2.relations! << 3

      c1.relations.assert == [1,2]
      c2.relations.assert == [1,2,3]
    end

  end

end

test_case Module do

  method :class_inheritor do

    test do
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

      m1.koko.assert  == [1]
      c1.koko.assert == [1,2,3]
      c2.koko.assert == [1,4]
    end

  end

end

=begin
Test.class Inheritor do
  setup do
    a = [1]
    @i = Inheritor.new(a, [2], :+)
  end
  method :== do
    test do
      @i.assert == [2]
    end
  end
  method :inheritance do
    test do
      @i.inheritance == [1,2]
    end
  end
end
=end
