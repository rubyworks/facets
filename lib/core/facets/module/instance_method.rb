#
class Module

  # Access method as a singleton object and retain state.
  #
  #   module K
  #     def hello
  #       puts "Hello World!"
  #     end
  #   end
  #   p K.instance_method!(:hello)   #=> <UnboundMethod: #hello>
  #
  # NOTE: This is limited to the scope of the current module/class.

  def instance_method!(s)
    #( @@__instance_methods__ ||= {} )[s] ||= instance_method(s)  # TODO when fixed
    ( @__instance_methods__ ||= {} )[s.to_sym] ||= instance_method(s.to_sym)
  end

end

