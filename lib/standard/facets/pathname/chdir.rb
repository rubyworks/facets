class Pathname

  # Change current working directory of the process
  # to the given path
  #
  # See Dir.chdir
  #
  # CREDIT: Ryan Duryea

  def chdir(&block)
    Dir.chdir(self, &block)
  end

end

