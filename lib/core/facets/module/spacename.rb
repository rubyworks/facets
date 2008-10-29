class Module

  # Returns the name of module's container module.
  #
  #   module Example
  #     class Demo
  #     end
  #   end
  #
  #   Demo.name         #=> "Example::Demo"
  #   Demo.spacename    #=> "Example"
  #
  # This used to be called +dirname+.
  #
  # See also Module#basename.
  #
  #  CREDIT: Trans

  def spacename
    name[0...(name.rindex('::') || 0)]
    #name.gsub(/::[^:]*$/, '')
  end

end

