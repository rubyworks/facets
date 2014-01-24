require 'facets/fileutils/outofdate'

class Pathname

  # Is a path out of date relative a set of source files.
  #
  # Returns [Boolean]

  def outofdate?(*sources)
    ::FileUtils.outofdate?(to_s, sources.flatten)
  end

end
