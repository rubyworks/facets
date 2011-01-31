covers 'facets/module/class_extend'

tests Module do

  setup "module using class_extend" do
    Module.new do
      def i ; end
      class_extend do
        def n ; 42   ; end
        def s ; self ; end
      end
    end
  end

  unit :class_extend => "extends module" do |mod|
    mod.n.assert == 42
    mod.s.assert == mod
  end

  unit :class_extend => "has expected methods" do |mod|
    mod.instance_methods.map{ |m| m.to_s }.assert == ['i']
  end

  unit :class_extend => "transfers class methods to including class" do |mix|
    mod = Module.new do
      include mix
    end
    mod.n.assert == 42
    mod.s.assert == mod
  end

  unit :class_extend => "doesn't overwrite instance methods" do |mix|
    c = Class.new do
      include mix
      def n ; 11 ; end
    end
    c.new.n.assert == 11
  end

  unit :class_extend => "is overridable via including module" do |mix|
    mod = Module.new do
      include mix
      class_extend do
        def n ; super + 1 ; end
      end
    end
    mod.n.assert == 43  # notice the difference!
    mod.s.assert == mod
  end

  unit :class_extend => "transfers class methods thru multiple levels of include" do |mix|
    alt = Module.new do
      include mix
      class_extend do
        def n ; super + 1 ; end
      end
    end
    mod = Module.new do
      include alt
    end
    mod.n.assert == 43
    mod.s.assert == mod
  end

end

