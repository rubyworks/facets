class Hash

  # @deprecated Use Hash#dig instead (built-in since Ruby 2.3).
  #   Scheduled for removal after 2027-09-30.
  #
  # Similar to Hash#dig but supports a block for missing keys,
  # like Hash#fetch does. Ruby's #dig does not support a block.
  #
  # TODO: Consider proposing block support for Hash#dig to Ruby core.
  #
  def fetch_nested(*keys, &block)
    warn "Hash#fetch_nested is deprecated. Use Hash#dig instead. It will be removed after 2027-09-30.", uplevel: 1
    begin
      keys.reduce(self) { |accum, k| accum.fetch(k) }
    rescue KeyError
      block_given? ? yield(*keys) : nil
    end
  end

end
