module Kernel

  # Send only to public methods.
  #
  #   class SendExample
  #     private
  #     def foo; end
  #   end
  #
  #   obj = SendExample.new
  #
  #   expect NoMethodError do
  #     obj.object_send(:foo)
  #   end
  #
  # DEPRECATED: Use #public_send instead.

  alias object_send public_send rescue nil

  #def object_send(name, *args, &blk)
  #  #instance_eval "self.#{name}(*args)"
  #  if respond_to?(name)
  #    __send__(name, *args, &blk)
  #  else
  #    __send__(:method_missing, name, *args, &blk)
  #  end
  #end

end

