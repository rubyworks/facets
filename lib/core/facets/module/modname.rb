class Module

  # Returns the name of the module containing this one.
  #
  #   module ::ParentExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   ParentExample::M::N.namespace  #=> "ParentExample::M"
  #
  def namespace
    unless defined? @_namespace
      @_namespace = name =~ /::[^:]+\Z/ ? $`.freeze : nil
    end
    @_namespace
  end

end
