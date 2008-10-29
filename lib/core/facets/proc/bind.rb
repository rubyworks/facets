class Proc

  # Bind a Proc to an object returning a Method.
  #
  # NOTE: This version comes from Rails. The old Facets
  #       version used thread.rb, but I no longer think
  #       the implementaiton is thread critical. Please
  #       make a bug report if this proves wrong.

  def bind(object)
    block, time = self, Time.now
    (class << object; self; end).class_eval do
      method_name = "__bind_#{time.to_i}_#{time.usec}"
      define_method(method_name, &block)
      method = instance_method(method_name)
      remove_method(method_name)
      method
    end.bind(object)
  end

end

