class Class

  # Automatically create an initializer assigning the given
  # arguments.
  #
  #   class MyClass
  #     initializer(:a, "b", :c)
  #   end
  #
  # _is equivalent to_
  #
  #   class MyClass
  #     def initialize(a, b, c)
  #       @a,@b,@c = a,b,c
  #     end
  #   end
  #
  # Downside: Initializers defined like this can't take blocks.
  # This can be fixed when Ruby 1.9 is out.
  #
  # The initializer will not raise an Exception when the user
  # does not supply a value for each instance variable. In that
  # case it will just set the instance variable to nil. You can
  # assign default values or raise an Exception in the block.

  def initialize_on(*attributes, &block)
    define_method(:initialize) do |*args|
      attributes.zip(args) do |sym, value|
        instance_variable_set("@#{sym}", value)
      end
      instance_eval(&block) if block
    end
    attributes
  end

end


=begin test

  require 'facets/class/initialize_on.rb'

  require 'test/unit'

  class TC_Class_Initializer < Test::Unit::TestCase

    def test_initialize_on
      cc = Class.new
      cc.class_eval {
        initialize_on :ai
        attr_reader :ai
      }
      c = cc.new(10)
      assert_equal( 10, c.ai )
    end

  end

=end

