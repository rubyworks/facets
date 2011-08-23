class String

  # Converts a camelcase name (e.g. class or module name) to a unix path.
  #
  #   "ExamplePathize".pathize           #=> "example_pathize"
  #   "ExamplePathize::Example".pathize  #=> "example_pathize/example"
  #
  def pathize
    gsub(/([A-Z]+)([A-Z])/,'\1_\2').
    gsub(/([a-z])([A-Z])/,'\1_\2').
    gsub('__','/').
    gsub('::','/').
    downcase
  end

  #--
  # Rails definition ...
  #
  #    gsub(/__/, '/').
  #    gsub(/::/, '/').
  #    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
  #    gsub(/([a-z\d])([A-Z])/,'\1_\2').
  #    tr("-", "_").
  #    downcase
  #++

end

