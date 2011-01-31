module Kernel
  # Calling Kernel#trap() by itself will replace any previously registered
  # handler code. Kernel#trap_chain(), on the other hand, will add the block
  # you supply to the existing "list" of registered handler blocks. Similar
  # to the way Kernel#at_exit() works, Kernel#trap_chain() will prepend the
  # given block to the call chain for the given signal_name. When the signal
  # occurs, your block will be executed first and then the previously
  # registered handler will be invoked. This can be called repeatedly
  # to create a "chain" of handlers. 
  #
  # CREDIT: Tyler Rick
  def trap_chain(signal_name, *args, &block)
    previous_interrupt_handler = trap(signal_name, *args) {}
    trap(signal_name, *args) do
      block.call
      previous_interrupt_handler.call unless previous_interrupt_handler == "DEFAULT"
    end
  end

end
