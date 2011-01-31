require 'facets/proc/bind'
require 'facets/kernel/singleton_class'

class Proc

  # Convert Proc to method.
  #
  #   object = Object.new
  #
  #   function = lambda { |x| x + 1 }
  #
  #   function.to_method(object, 'foo')
  #
  #   object.foo(1)  #=> 2
  #
  def to_method(object, name=nil)
    ##object = object || eval("self", self)
    block, time = self, Time.now
    method_name = name || "__bind_#{time.to_i}_#{time.usec}"
    begin
      object.singleton_class.class_eval do
        define_method(method_name, &block)
        method = instance_method(method_name)
        remove_method(method_name) unless name
        method
      end.bind(object)
    rescue TypeError
      object.class.class_eval do
        define_method(method_name, &block)
        method = instance_method(method_name)
        remove_method(method_name) unless name
        method
      end.bind(object)
    end
  end

end

