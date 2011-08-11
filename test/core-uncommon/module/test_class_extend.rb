covers 'facets/module/class_extend'

test_case Module do

  method :class_extend do

    setup "module using class_extend" do
      @mod = Module.new do
              def i ; end
              class_extend do
                def n ; 42   ; end
                def s ; self ; end
              end
            end
    end

    test "extends module" do
      @mod.n.assert == 42
      @mod.s.assert == @mod
    end

    test "has expected methods" do
      @mod.instance_methods.map{ |m| m.to_s }.assert == ['i']
    end

    test "transfers class methods to including class" do
      mod = @mod
      mod = Module.new do
        include mod
      end
      mod.n.assert == 42
      mod.s.assert == mod
    end

    test "doesn't overwrite instance methods" do
      mod = @mod
      c = Class.new do
        include mod
        def n ; 11 ; end
      end
      c.new.n.assert == 11
    end

    test "is overridable via including module" do
      mod = @mod
      m = Module.new do
        include mod
        class_extend do
          def n ; super + 1 ; end
        end
      end
      m.n.assert == 43  # notice the difference!
      m.s.assert == m
    end

    test "transfers class methods thru multiple levels of include" do
      mod = @mod
      a = Module.new do
        include mod
        class_extend do
          def n ; super + 1 ; end
        end
      end
      m = Module.new do
        include a
      end
      m.n.assert == 43
      m.s.assert == m
    end

  end

end
