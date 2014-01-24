require 'facets/filetest/safe'

class Pathname

  # Is a path reasonably safe?
  #
  # Do not mistake this for a perfect solution!
  #
  # Returns [Boolean]

  def safe?
    FileTest.safe?(to_s)
  end

end
