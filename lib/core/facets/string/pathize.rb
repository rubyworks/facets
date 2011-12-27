class String

  # Transforms a namespace, i.e. a class or module name, into a viable 
  # file path.
  #
  #   "ExamplePathize".pathize           #=> "example_pathize"
  #   "ExamplePathize::Example".pathize  #=> "example_pathize/example"
  #
  # Compare this method to {String#modulize) and {String#methodize).
  #
  def pathize
    gsub(/([A-Z]+)([A-Z])/,'\1_\2').
    gsub(/([a-z])([A-Z])/,'\1_\2').
    gsub('__','/').
    gsub('::','/').
    gsub(/\s+/, '').                # spaces are bad form
    gsub(/[?%*:|"<>.]+/, '').   # reserved characters
    downcase
  end

  # Compare to Rails definition:
  #
  #    gsub(/__/, '/').
  #    gsub(/::/, '/').
  #    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
  #    gsub(/([a-z\d])([A-Z])/,'\1_\2').
  #    tr("-", "_").
  #    downcase
  #

end

