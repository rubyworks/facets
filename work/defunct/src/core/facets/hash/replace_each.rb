class Hash

  # Same as #update_each, but deletes the key element first.
  #
  # CREDIT: Trans

  def replace_each  # :yield:
    dup.each do |k,v|
      delete(k)
      update(yield(k,v))
    end
    self
  end

end

