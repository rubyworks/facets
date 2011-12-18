class Module

  # Returns the root name of the module/class.
  #
  #   module ::BaseName
  #     class Example
  #     end
  #   end
  #
  #   BaseName::Example.name       #=> "BaseName::Example"
  #   BaseName::Example.basename   #=> "Example"
  #
  # For anonymous modules this will provide a basename
  # based on Module#inspect.
  #
  #   m = Module.new
  #   m.inspect       # "#<Module:0xb7bb0434>"
  #   m.basename      # "Module_0xb7bb0434"
  #
  # CREDIT: Trans

  def basename
    if name and not name.empty?
      name.gsub(/^.*::/, '')
    else
      nil #inspect.gsub('#<','').gsub('>','').sub(':', '_')
    end
  end

end

