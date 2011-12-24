module Kernel

  # Hierarchically apply a block, passing each ancestor to the block
  # starting at the root ancestor and working toward the current object.
  #
  # @todo Include singleton class?
  def hierarchically(&block)
    self.class.ancestors.reverse_each do |m|
      block.call(m)
    end
  end

  # Send a message to each ancestor in an object's class hierarchy.
  # The method will only be called if the method is defined for the
  # ancestor.
  # 
  # This can be very useful for setting up a `preinitialize` system.
  #
  #   m = Module.new do
  #         attr :a
  #         def preinitialize
  #           @a = 1
  #         end
  #       end
  #         
  #   c = Class.new do
  #         include m
  #         def initialize
  #           hierarchical_send(:preinitialize)
  #         end
  #       end
  #
  #   c.new.a  #=> 1
  #
  def hierarchical_send(method_name, *args, &block)
    method_name = method_name.to_s if RUBY_VERSION < '1.9'
    this = self
    hierarchically do |anc|
      ## is there really no better way to check for the method?
      if anc.instance_methods(false).include?(method_name) or
           anc.public_instance_methods(false).include?(method_name) or
           anc.private_instance_methods(false).include?(method_name) or
           anc.protected_instance_methods(false).include?(method_name)
        im = anc.instance_method(method_name)
        ##im.arity == 0 ? im.bind(this).call(&block) : im.bind(this).call(*args, &block)
        im.bind(this).call(*args, &block)
      end
    end
  end

end
