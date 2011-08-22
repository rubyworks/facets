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
  # TODO: object_send needs to change for 1.9. Is it #public_send ?
  #
  # CREDIT: Trans
  #--
  # Which implementation is faster?
  #++

  def object_send(name, *args, &blk)
    #instance_eval "self.#{name}(*args)"
    if respond_to?(name)
      __send__(name, *args, &blk)
    else
      __send__(:method_missing, name, *args, &blk)
    end
  end

end

