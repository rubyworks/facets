require 'facets/proc/bind'

class Proc

  # Convert Proc to method.
  #
  #   plusproc = lambda { |x| x + 1 }
  #   plusproc.to_method(self, 'foo')
  #   X.new.foo(1)  #=> 2

  def to_method(object, name=nil)
    #object = object || eval("self", self)
    block, time = self, Time.now
    method_name = name || "__bind_#{time.to_i}_#{time.usec}"
    begin
      (class << object; self; end).class_eval do
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

