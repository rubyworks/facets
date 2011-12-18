class Hash

  # Instantiate a new hash with a default
  # value determined by the block.
  # 
  # Hash.new_with{ [] } 
  #
  # CREDIT: Pit Capitan

  def self.new_with #:yield:
    new { |h, k| h[k] = yield }
  end

end

