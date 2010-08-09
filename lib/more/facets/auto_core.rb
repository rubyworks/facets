require 'facets/opesc'

module Kernel

  # This will automatically load (most) core methods
  # if they are not present when called.

  def method_missing(methodname, *a, &b)
    methodname = OpEsc.escape(methodname)
    begin
      require "facets/#{class}/#{methodname}"
      __send__(methodname, *a, &b)  # retry ?
    rescue LoadError
      super(methodname, *a, &b)
    end  
  end

end

