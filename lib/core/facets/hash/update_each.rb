class Hash

  # Iterates through each pair and updates the hash
  # in place. This is formally equivalent to #mash!
  # But does not use #mash to accomplish the task.
  # Hence #update_each is probably a touch faster.
  #
  # CREDIT: Trans

  def update_each  # :yield:
    dup.each do |k,v|
     update(yield(k,v))
    end
    self
  end

end

