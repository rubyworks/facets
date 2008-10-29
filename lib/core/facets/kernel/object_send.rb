module Kernel

  # Send only to public methods.
  #
  #   class X
  #     private
  #     def foo; end
  #   end
  #
  #   X.new.object_send(:foo)
  #   => NoMethodError: private method `foo' called for #<X:0xb7ac6ba8>
  #
  # TODO: object_send needs to change for 1.9.
  #
  #  CREDIT: Trans
  #--
  # Which implementation is faster?
  #++

  def object_send(name,*args,&blk)
    #instance_eval "self.#{name}(*args)"
    if respond_to?(name)
      send(name,*args,&blk)
    else #if respond_to?(:method_missing)
      method_missing(name,*args,&blk)
    #else
    #  raise NoMethodError
    end
  end

end

