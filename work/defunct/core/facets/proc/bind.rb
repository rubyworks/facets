class Proc

  # Bind a Proc to an object returning a Method.
  #
  # The block's #to_s method (same as #inspect) is
  # used for the temporary method label defined in
  # the Object class.
  #
  #   NOTE: This dynamically loads thread.so if used.
  #   NOTE: Not so sure it is thread critical anymore.

  def bind(object=nil)
    require 'thread'

    object = object || eval("self", self)
    block  = self
    store  = Object

    begin
      old, Thread.critical = Thread.critical, true
      @n ||= 0; @n += 1
      name = "_bind_#{@n}#{block.object_id}"
      store.module_eval do
        define_method name, &block
      end
      meth = object.method(name)
    ensure
      store.module_eval do
        remove_method name #rescue nil
        #undef_method name #rescue nil
      end
      Thread.critical = old
    end

    return meth
  end

end
