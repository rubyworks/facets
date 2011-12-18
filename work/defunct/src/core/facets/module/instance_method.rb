$FIRST_CLASS_INSTANCE_METHODS = Hash.new{ |h,k| h[k] = {} }

#
class Module

  # Access method as a singleton object and retain state.
  #
  #   module ::K
  #     def hello
  #       puts "Hello World!"
  #     end
  #   end
  #
  #   K.instance_method!(:hello).inspect   #=> "#<UnboundMethod: K#hello>"
  #
  # NOTE: This is limited to the scope of the current module/class.

  def instance_method!(s)
    #( @@__instance_methods__ ||= {} )[s] ||= instance_method(s)  # TODO: use class vars for 1.9+ ?
    #( @__instance_methods__ ||= {} )[s.to_sym] ||= instance_method(s.to_sym)
    $FIRST_CLASS_INSTANCE_METHODS[self][s.to_sym] ||= instance_method(s.to_sym)
  end

end

