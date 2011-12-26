require 'facets/more/functor'

module Namespace

  #

  def namespace(name, &block)
    define_method(name) do
      Functor.new do |op, *args|
        send("#{name}:#{op}",*args)
      end
    end
    begin
      @namespace = name
      module_eval &block
    ensure
      @namespace = nil
    end
  end

  #

  def method_added(name)
    return if @method_being_added
    if @namespace
      @method_being_added = true
      alias_method "#{@namespace}:#{name}", name
      undef_method name
      @method_being_added = false
    end
  end

end


class X
  extend Namespace

  def initialize(x)
    @x = x
  end

  namespace :m do
    def x ; @x; end
  end
end

x = X.new(6)
p x.m.x
p x.x


exit

require 'facets/more/functor'
require 'facets/core/module/basename'

class Module

  # Define a simple namespace.
  #
  #   class A
  #     attr_writer :x
  #     namespace :inside do
  #       def x; @x; end
  #     end
  #   end
  #   a = A.new
  #   a.x = 10
  #   a.inside.x #=> 10
  #   a.x  # no method error

  def namespace( mod, &blk )

    # If block is given then create a module, othewise
    # get the name of the module.
    if block_given?
      name = mod.to_s
      mod  = Module.new(&blk)
    else
      name = mod.basename.downcase
      mod  = mod.dup
    end

    # We have to work around name clashes.
    nameclashes = mod.instance_methods & instance_methods
    nameclashes.each do |n|
      alias_method "#{n}:namespace", n
    end

    # Include the module. This is neccessary, otherwise
    # Ruby won't let us bind the instance methods.
    include mod

    # Undefine the instance methods of the module.
    mod.instance_methods.each{ |m| undef_method m }

    # Redefine the methods that clashed.
    nameclashes.each do |n|
      alias_method n, "#{n}:namespace"
      undef_method "#{n}:namespace"
    end

    # Add a method for the namespace that delegates
    # via the Functor to the module instance methods.
    define_method(name) do
      Functor.new(mod) do |op, base, *args|
        base.instance_method(op).bind(self).call(*args)
      end
    end
  end

end



=begin test

  require 'test/unit'

  class TestNamespace1 < Test::Unit::TestCase

    module M
      def x; "x"; end
    end

    class C
      namespace M
    end

    def test_01
      c = C.new
      assert_equal('x', c.m.x)
    end

    def test_02
      c = C.new
      assert_raises(NoMethodError){ c.x }
    end

  end


  class TestNamespace2 < Test::Unit::TestCase

    class B
      def x; 1; end
    end

    class C < B
      def x; super; end
      namespace :m do
        def x; "x"; end
      end
    end

    def test_01
      c = C.new
      assert_equal('x', c.m.x)
    end

    def test_02
      c = C.new
      assert_equal(1, c.x)
    end

  end

=end
