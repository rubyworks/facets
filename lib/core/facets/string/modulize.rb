class String

  # Converts a string to module name representation.
  #
  # This is essentially #camelcase. It also converts
  # '/' to '::' which is useful for converting
  # paths to namespaces.
  #
  # Examples
  #   "method_name".modulize    #=> "MethodName"
  #   "method/name".modulize    #=> "Method::Name"
  #
  def modulize
    gsub('__','/').
    gsub(/\/(.?)/){ "::#{$1.upcase}" }.
    gsub(/(?:_+|-+)([a-z])/){ $1.upcase }.
    gsub(/(\A|\s)([a-z])/){ $1 + $2.upcase }
  end

end

