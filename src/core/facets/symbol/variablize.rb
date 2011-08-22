class Symbol

  # Prepend an "@" to the beginning of a symbol to make a instance
  # variable name. This also replaces non-valid characters with underscores.
  #
  #   :a.variablize  #=> :"@a"
  #
  def variablize
    name = to_s.gsub(/\W/, '_')
    "@#{name}".to_sym
  end

end

