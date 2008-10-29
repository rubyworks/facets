class Module

  # Returns the module's container module.
  #
  #   module Example
  #     class Demo
  #     end
  #   end
  #
  #   Example::Demo.modspace   #=> Example
  #
  # See also Module#basename.
  #
  #   CREDIT: Trans

  def modspace
    space = name[ 0...(name.rindex( '::' ) || 0)]
    space.empty? ? Object : eval(space)
  end

end

