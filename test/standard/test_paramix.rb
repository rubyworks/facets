covers 'facets/paramix'

test_case Paramix::Extensions do

  # A parametric module that defines the method named by :name, returning
  # :value.
  maker = lambda do
    Module.new do
      include Paramix
      parameterized do |params|
        public(params[:name]) { params[:value] }
      end
    end
  end

  method :parameterized do

    test "is added to a module that includes Paramix" do
      m = maker.call
      m.assert.respond_to?(:parameterized)
      m.assert.respond_to?(:[])
    end

    test "Paramix::Parametric, its name in the gem, is the same module" do
      Paramix::Parametric.assert.equal?(Paramix)
      m = Module.new do
        include Paramix::Parametric
        parameterized { |params| public(:f) { params[:p] } }
      end
      Class.new { include m[:p => 1] }.new.f.assert == 1
    end

  end

  method :[] do

    test "parameters are given where the module is included" do
      m = maker.call
      c = Class.new { include m[:name => :f, :value => 1] }
      c.new.f.assert == 1
    end

    test "each inclusion has its own parameters" do
      m = maker.call
      a = Class.new { include m[:name => :f, :value => 'a'] }
      b = Class.new { include m[:name => :f, :value => 'b'] }
      a.new.f.assert == 'a'
      b.new.f.assert == 'b'
    end

    test "parameters are given where the module is extended" do
      m = maker.call
      a = Class.new { extend m[:name => :f, :value => 'mosh'] }
      b = Class.new { extend m[:name => :f, :value => 'many'] }
      a.f.assert == 'mosh'
      b.f.assert == 'many'
    end

    test "the module's own methods come along" do
      m = Module.new do
        include Paramix
        parameterized do |params|
          define_method(:params) { params }
        end
        def hello
          "Hello, %s!" % [params[:name]]
        end
      end
      c = Class.new { include m[:name => 'Charlie'] }
      c.new.hello.assert == "Hello, Charlie!"
    end

    test "the block can define any methods from its parameters" do
      m = Module.new do
        include Paramix
        parameterized do |params|
          attr_accessor params[:p]
        end
      end
      c = Class.new { include m[:p => :color] }
      o = c.new
      o.color = :red
      o.color.assert == :red
    end

    test "private and protected define methods with that visibility" do
      m = Module.new do
        include Paramix
        parameterized do |params|
          private(:secret) { params[:value] }
          protected(:guarded) { params[:value] }
          public(:reveal) { secret }
        end
      end
      c = Class.new { include m[:value => 42] }
      c.new.reveal.assert == 42
      c.private_instance_methods.assert.include?(:secret)
      c.protected_instance_methods.assert.include?(:guarded)
    end

    test "public, private and protected still take names alone" do
      m = Module.new do
        include Paramix
        parameterized do |params|
          define_method(:a) { 1 }
          define_method(:b) { 2 }
          private :a, :b
        end
      end
      c = Class.new { include m[] }
      c.private_instance_methods.assert.include?(:a)
      c.private_instance_methods.assert.include?(:b)
    end

    test "a parametric module can include another with parameters" do
      inner = maker.call
      outer = Module.new do
        include Paramix
        include inner[:name => :f, :value => 1]
        parameterized do |params|
          public(params[:name]) { params[:value] }
        end
      end
      c = Class.new { include outer[:name => :g, :value => 2] }
      c.new.f.assert == 1
      c.new.g.assert == 2
    end

    test "a module that includes one without parameters becomes parametric" do
      inner = maker.call
      outer = Module.new do
        include inner
        parameterized do |params|
          public(params[:name].to_s.succ) { params[:value] }
        end
      end
      c = Class.new { include outer[:name => :q, :value => 3] }
      c.new.q.assert == 3
      c.new.r.assert == 3
    end

    test "a plain module can pass a parameterized one on" do
      inner = maker.call
      plain = Module.new { include inner[:name => :f, :value => 'NMp'] }
      Class.new { include plain }.new.f.assert == 'NMp'
      Class.new { extend plain }.f.assert == 'NMp'
    end

  end

end
