class Module

  # Returns the root name of the module/class.
  #
  #   module Example
  #     class Demo
  #     end
  #   end
  #
  #   Demo.name       #=> "Example::Demo"
  #   Demo.basename   #=> "Demo"
  #
  # For anonymous modules this will provide a basename
  # based on Module#inspect.
  #
  #   m = Module.new
  #   m.inspect       #=> "#<Module:0xb7bb0434>"
  #   m.basename      #=> "Module_0xb7bb0434"
  #
  #   CREDIT: Trans

  def basename
    if name and not name.empty?
      name.gsub(/^.*::/, '')
    else
      nil #inspect.gsub('#<','').gsub('>','').sub(':', '_')
    end
  end

end

