class String

  # Prepend an "@" to the beginning of a string
  # to make a instance variable name. This also replaces
  # non-valid characters with underscores.

  def variablize
    v = gsub(/\W/, '_')
    "@#{v}"
  end

end

