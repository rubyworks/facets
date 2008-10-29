# = Component
#
#   module Foo
#     extend Component
#
#     def self_x; "X::x"; end
#
#     def x; "x"; end
#   end
#
#   class X
#     include Foo
#   end
#
#   X.x      #=> "X::x"
#   X.new.x  #=> "x"
#

module Component

  def class_module
    i = self
    @class_module ||= Module.new do
      include i
    end

#     @class_module.module_eval do
#       instance_methods.each do |name|
#         if md = /^self_/.match(name.to_s)
#           alias_method md.post_match, name
#           undef_method(name)
#         else
#           undef_method(name)
#         end
#       end
#     end

    @class_module
  end

  def instance_module
    i = self
    @instance_module ||= Module.new do
      include i
    end

#     @instance_module.module_eval do
#       instance_methods.each do |name|
#         if md = /^self_/.match(name.to_s)
#           undef_method(name)
#         end
#       end
#     end

    @instance_module
  end

  def method_added(name)
    if md = /^self_/.match(name.to_s)
      class_module.send(:alias_method, md.post_match, name)
      class_module.send(:undef_method, name)
      instance_module.send(:undef_method, name)
    else
      class_module.send(:undef_method, name)
    end
  end

  def included(base)
    return if base.name.empty?
    base.extend(class_module)
  end

  def append_features(base)
    return super if base.name.empty?
    instance_module.send(:append_features, base)
  end

  #def included(base)
  #  base.extend class_module
  #  instance_methods(false).each do |name|
  #    if md = /^self_/.match(name.to_s)
  #      base.send(:undef_method, name)
  #    end
  #  end
  #end

end


# __TEST__

=begin test
  require 'test/unit'

  class TestComponent < Test::Unit::TestCase

    module Foo
     extend Component

     def x; "x"; end

     def self_x; "X::x"; end

     #def x; "x"; end
   end

    class X
      include Foo
    end

    def test_class_method
      assert_equal("X::x", X.x)
    end

    def test_instance_method
      assert_equal("x", X.new.x)
    end

  end
=end
