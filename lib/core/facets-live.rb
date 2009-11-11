require 'facets/opesc'

class Object

  # This will automatically load (most) core methods
  # if they are not present when called.

  def method_missing(methodname, *a, &b)
    methodname = OpEsc.escape(methodname)
    begin
      require "facets/#{class}/#{methodname}"
      __send__(methodname, *a, &b)
    rescue LoadError
      super
    end  
  end

end

