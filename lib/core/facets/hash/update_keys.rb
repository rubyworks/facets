class Hash

  # @deprecated Use Hash#transform_keys! (Ruby 2.5+) or Hash#rekey! instead.
  #
  def update_keys(&block)
    warn "Hash#update_keys is deprecated. Use Hash#transform_keys! or Hash#rekey! instead.", uplevel: 1
    if block_given?
      transform_keys!(&block)
    else
      to_enum(:update_keys)
    end
  end

end
