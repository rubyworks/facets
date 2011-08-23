class String

  # Translate a (class or module) name to a suitable method name.
  #
  #   "My::CoolClass".methodize  #=> "my__cool_class"
  #
  #--
  # Rails definition ...
  #
  #    gsub(/\//, '__').
  #    gsub(/::/, '__').
  #    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
  #    gsub(/([a-z\d])([A-Z])/,'\1_\2').
  #    tr("-", "_").
  #    downcase
  #
  #++
  def methodize
    gsub(/([A-Z]+)([A-Z])/,'\1_\2').
    gsub(/([a-z])([A-Z])/,'\1_\2').
    gsub('/' ,'__').
    gsub('::','__').
    downcase
  end

end

