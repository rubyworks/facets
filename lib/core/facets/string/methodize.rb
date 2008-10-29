class String

  # Translate a (class or module) name to a suitable method name.
  #
  #   My::CoolClass.name.methodize => "my__cool_class"
  #
  def methodize
    gsub(/([A-Z]+)([A-Z])/,'\1_\2').
    gsub(/([a-z])([A-Z])/,'\1_\2').
    gsub('/' ,'__').
    gsub('::','__').
    downcase
  end

end


