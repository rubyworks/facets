covers 'facets/no_backsies'

test_case NoBacksies::CallbackMethods do

  # A class that includes NoBacksies and keeps a list.
  maker = lambda do |mod = NoBacksies|
    Class.new do
      include mod
      def self.list
        @list ||= []
      end
    end
  end

  method :callback do

    test "a callback is run each time" do
      c = maker.call
      c.class_eval do
        callback(:method_added){ |m| list << m }
        def foo; end
        def bar; end
      end
      c.list.assert == [:foo, :bar]
    end

    test "NoBacksies::Callbacks, its name in the gem, does the same" do
      c = maker.call(NoBacksies::Callbacks)
      c.class_eval do
        callback(:method_added){ |m| list << m }
        def foo; end
      end
      c.list.assert == [:foo]
    end

    test "a callback's module can be included alone" do
      c = maker.call(NoBacksies::MethodAdded)
      c.class_eval do
        callback(:method_added){ |m| list << m }
        def foo; end
      end
      c.list.assert == [:foo]
      c.singleton_class.include?(NoBacksies::Inherited).assert == false
    end

    test "several callbacks run in the order they were defined" do
      c = maker.call
      c.class_eval do
        callback(:method_added){ |m| list << 1 }
        callback(:method_added){ |m| list << 2 }
        def foo; end
      end
      c.list.assert == [1, 2]
    end

    test "it needs a block" do
      c = maker.call
      ArgumentError.assert.raised?{ c.callback(:method_added) }
    end

    test "the callback methods stay private" do
      c = maker.call
      c.callback(:inherited){ |sub| }
      c.private_methods.assert.include?(:method_added)
      c.private_methods.assert.include?(:inherited)
    end

    test "with :once it is used one time" do
      c = maker.call
      c.class_eval do
        callback(:method_added, :once=>true){ |m| list << m }
        def foo; end
        def bar; end
      end
      c.list.assert == [:foo]
      c.callbacks[:method_added].assert.empty?
    end

    test "with :safe it can define a method without calling itself" do
      c = maker.call
      c.class_eval do
        callback(:method_added, :safe=>true) do |m|
          define_method("#{m}!"){ send(m) + "!" }
        end
        def foo; "foo"; end
        def bar; "bar"; end
      end
      c.new.foo!.assert == "foo!"
      c.new.bar!.assert == "bar!"
      c.new.refute.respond_to?(:"foo!!")
    end

  end

  method :callback_express do

    test "switches a callback off for a block" do
      c = maker.call
      c.class_eval do
        callback(:method_added){ |m| list << m }
        def foo; end
        callback_express(:method_added=>false) do
          def quiet; end
        end
        def bar; end
      end
      c.list.assert == [:foo, :bar]
    end

    test "switches it back on when the block raises" do
      c = maker.call
      begin
        c.callback_express(:method_added=>false){ raise "oops" }
      rescue RuntimeError
      end
      c.callback_express[:method_added].assert == true
    end

    test "without a block the change stays" do
      c = maker.call
      c.class_eval do
        callback(:method_added){ |m| list << m }
        callback_express(:method_added=>false)
        def foo; end
        callback_express(:method_added=>true)
        def bar; end
      end
      c.list.assert == [:bar]
    end

  end

  method :callback_invoke do

    test "a subclass has its superclass's callbacks, which run first" do
      seen = []
      c = maker.call
      c.callback(:method_added){ |m| seen << [:parent, m] }
      d = Class.new(c)
      d.callback(:method_added){ |m| seen << [:child, m] }
      d.class_eval{ def foo; end }
      seen.assert == [[:parent, :foo], [:child, :foo]]
    end

    test "a subclass's callback is not its superclass's" do
      seen = []
      c = maker.call
      d = Class.new(c)
      d.callback(:method_added){ |m| seen << m }
      c.class_eval{ def foo; end }
      seen.assert == []
      c.callbacks[:method_added].assert.empty?
    end

    test "super is called once, after the callbacks" do
      seen = []
      base = Class.new do
        define_singleton_method(:inherited) do |sub|
          seen << :super
          super(sub)
        end
      end
      c = Class.new(base){ include NoBacksies }
      seen.clear
      c.callback(:inherited){ |sub| seen << :one }
      c.callback(:inherited){ |sub| seen << :two }
      Class.new(c)
      seen.assert == [:one, :two, :super]
    end

    test "super is called when there is no callback" do
      seen = []
      base = Class.new do
        define_singleton_method(:inherited) do |sub|
          seen << :super
          super(sub)
        end
      end
      c = Class.new(base){ include NoBacksies }
      seen.clear
      Class.new(c)
      seen.assert == [:super]
    end

    test "with :superless, super is left to the callback" do
      seen = []
      base = Class.new do
        define_singleton_method(:inherited) do |sub|
          seen << :super
          super(sub)
        end
      end
      c = Class.new(base){ include NoBacksies }
      seen.clear
      c.callback(:inherited, :superless=>true) do |sub, &superblock|
        superblock.call
        seen << :after
      end
      Class.new(c)
      seen.assert == [:super, :after]
    end

    test "the callback gives the constant's value" do
      c = maker.call
      c.callback(:const_missing){ |const| const.to_s.downcase }
      c.const_get(:FOO).assert == "foo"
    end

    test "the callback can fall back on super" do
      c = maker.call
      c.callback(:const_missing) do |const, &superblock|
        const == :FOO ? 1 : superblock.call
      end
      c.const_get(:FOO).assert == 1
      NameError.assert.raised?{ c.const_get(:BAR) }
    end

    test "without a callback a missing constant is still an error" do
      c = maker.call
      NameError.assert.raised?{ c.const_get(:FOO) }
    end

    test "is called for each class a module is included in" do
      m = Module.new do
        include NoBacksies
        def self.list
          @list ||= []
        end
        callback(:included){ |base| list << base }
      end
      x = Class.new{ include m }
      y = Class.new{ include m }
      m.list.assert == [x, y]
    end

    test "is called for each object a module extends" do
      m = Module.new do
        include NoBacksies
        def self.list
          @list ||= []
        end
        callback(:extended){ |obj| list << obj }
      end
      o = Object.new
      o.extend(m)
      m.list.assert == [o]
    end

    test "is called for each subclass" do
      c = maker.call
      c.callback(:inherited){ |sub| c.list << sub }
      d = Class.new(c)
      c.list.assert == [d]
    end

    test "is called when a method is removed or undefined" do
      c = maker.call
      c.class_eval do
        callback(:method_removed){ |m| list << [:removed, m] }
        callback(:method_undefined){ |m| list << [:undefined, m] }
        def foo; end
        def bar; end
        remove_method :foo
        undef_method :bar
      end
      c.list.assert == [[:removed, :foo], [:undefined, :bar]]
    end

    test "is called for singleton methods added, removed and undefined" do
      c = maker.call
      c.class_eval do
        callback(:singleton_method_added){ |m| list << [:added, m] }
        callback(:singleton_method_removed){ |m| list << [:removed, m] }
        callback(:singleton_method_undefined){ |m| list << [:undefined, m] }
        def self.foo; end
        def self.bar; end
        singleton_class.send(:remove_method, :foo)
        singleton_class.send(:undef_method, :bar)
      end
      c.list.assert == [[:added, :foo], [:added, :bar], [:removed, :foo], [:undefined, :bar]]
    end

  end

end
