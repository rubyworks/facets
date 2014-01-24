class Pathname

  # Is a path up to date relative to a set of source files?
  #
  # Returns [Boolean]

  def uptodate?(*sources)
    ::FileUtils.uptodate?(to_s, sources.flatten)
  end

end
