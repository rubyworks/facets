class Module

  # Returns the name of the module containing this one.
  #
  #   module ::NSExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   NSExample::M::N.modname  #=> "NSExample::M"
  #
  # See also Module#basename.
  def modname
    unless defined? @_modname
      @_modname = name =~ /::[^:]+\Z/ ? $`.freeze : nil
    end
    @_modname
  end

end
