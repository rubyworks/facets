class Array

  # Class level rendition of Array#zip.
  #
  # arrays - List of arrays to zip. [Array<Array>]
  #
  # Example:
  #
  #   Array.zip([1,2],[3,4]]
  #   #=> [[1,3],[2,4]]
  #
  # Returns arranged array of arrays. [Array<Array>]
  #
  # Returns an empty array if no arguments are given. [Array]

  def self.zip(*arrays)
    return [] if arrays.empty?
    return arrays[0].zip(*arrays[1..-1])
  end

end
