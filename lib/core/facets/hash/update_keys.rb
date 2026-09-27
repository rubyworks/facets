class Hash

  # @deprecated Use Hash#transform_keys! (Ruby 2.5+) or Hash#rekey! instead.
  #   Scheduled for removal after 2027-09-30.
  #
  def update_keys(&block)
    warn "Hash#update_keys is deprecated. Use Hash#transform_keys! or Hash#rekey! instead. It will be removed after 2027-09-30.", uplevel: 1
    if block_given?
      transform_keys!(&block)
    else
      to_enum(:update_keys)
    end
  end

end
