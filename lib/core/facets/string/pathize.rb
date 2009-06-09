class String

  # Converts a (class or module) name to a unix path.
  #
  #   My::CoolClass.name.pathize  #=> "my/cool_class"
  #
  #--
  # Rails definition:
  #
  #    gsub(/__/, '/').
  #    gsub(/::/, '/').
  #    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
  #    gsub(/([a-z\d])([A-Z])/,'\1_\2').
  #    tr("-", "_").
  #    downcase
  #++
  def pathize
    gsub(/([A-Z]+)([A-Z])/,'\1_\2').
    gsub(/([a-z])([A-Z])/,'\1_\2').
    gsub('__','/').
    gsub('::','/').
    downcase
  end

end

