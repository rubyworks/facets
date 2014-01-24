class Pathname

  # Is a directory path empty?
  #
  # Returns [Boolean]
  def empty?
    Dir.glob(::File.join(to_s, '*')).empty?
  end

end
