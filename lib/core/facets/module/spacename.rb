class Module

  # Returns the name of module's container module.
  #
  #   module ::SpaceName
  #     class Example
  #     end
  #   end
  #
  #   SpaceName::Example.name         #=> "SpaceName::Example"
  #   SpaceName::Example.spacename    #=> "SpaceName"
  #
  # This used to be called +dirname+.
  #
  # See also Module#basename.
  #
  # CREDIT: Trans

  def spacename
    name[0...(name.rindex('::') || 0)]
    #name.gsub(/::[^:]*$/, '')
  end

end

