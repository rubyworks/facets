class Array

  # Class level rendition of Array#zip.
  #
  # arrays - List of arrays to zip. [Array<Array>]
  #
  # Returns empty array if no arguments are given. [Array]

  def self.zip(*arrays)
    return [] if arrays.empty?
    return arrays[0].zip(*arrays[1..-1])
  end

end
