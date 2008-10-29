class String

  # Converts a (class or module) name to a unix path.
  #
  #   My::CoolClass.name.pathize  #=> "my/cool_class"
  #
  def pathize
    gsub(/([A-Z]+)([A-Z])/,'\1_\2').
    gsub(/([a-z])([A-Z])/,'\1_\2').
    gsub('__','/').
    gsub('::','/').
    downcase
  end

end

