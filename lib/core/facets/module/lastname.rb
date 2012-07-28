class Module

  # Returns the root name of the module/class.
  #
  #   module ::BaseName
  #     class Example
  #     end
  #   end
  #
  #   BaseName::Example.name       #=> "BaseName::Example"
  #   BaseName::Example.lastname   #=> "Example"
  #
  # Returns nil when module is anonymous.
  #
  # CREDIT: Trans

  def lastname
    if name and not name.empty?
      name.gsub(/^.*::/, '')
    else
      nil #inspect.gsub('#<','').gsub('>','').sub(':', '_')
    end
  end

  # Original name, but conflicts with File.basename, so is
  # mildly deprecated. 
  alias basename lastname

end

