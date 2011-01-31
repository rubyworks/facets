class Module

  # Translate a class name to a suitable method name.
  #
  # Examples
  #   CoolClass.methodize => "cool_class"
  #   My::CoolClass.methodize => "my__cool_class"

  def methodize
    to_s.
      gsub(/::/, '__').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end

end

