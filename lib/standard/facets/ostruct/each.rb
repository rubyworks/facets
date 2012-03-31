require 'ostruct'

class OpenStruct

  # Iterate over key-value pairs.
  #
  def each(&blk)
    @table.each(&blk)
  end

end
