require 'facets/filetest/separator_pattern'

module FileTest

  module_function

  # Predicate method for testing whether a path is absolute.
  # It returns +true+ if the pathname begins with a slash.
  def absolute?(path)
    !relative?(path)
  end

  # The opposite of #absolute?
  def relative?(path)
    while r = chop_basename(path.to_s)
      path, basename = r
    end
    path == ''
  end

  # List File.split, but preserves the file separators.
  #
  #   chop_basename('/usr/lib') #=> ['/usr/', 'lib']
  #   chop_basename('/') #=> nil
  #
  # Returns Array of `[pre-basename, basename]` or `nil`.
  #
  # This method is here simply to support the #relative? and #absolute? methods.
  def chop_basename(path)
    base = File.basename(path)
    if /\A#{SEPARATOR_PATTERN}?\z/ =~ base
      return nil
    else
      return path[0, path.rindex(base)], base
    end
  end

end
