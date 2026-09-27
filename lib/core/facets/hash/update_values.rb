class Hash

  # @deprecated Use Hash#transform_values! (Ruby 2.4+) or Hash#revalue! instead.
  #   Scheduled for removal after 2027-09-30.
  #
  def update_values(&block)
    warn "Hash#update_values is deprecated. Use Hash#transform_values! or Hash#revalue! instead. It will be removed after 2027-09-30.", uplevel: 1
    if block_given?
      transform_values!(&block)
    else
      to_enum(:update_values)
    end
  end

end
