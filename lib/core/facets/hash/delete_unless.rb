class Hash

  # Inverse of #delete_if.
  #
  #   h = { :a => 1, :b => 2, :c => 3 }
  #   r = a.delete_unless{|k,v| v == 1}
  #   r  #=> { :a => 1 }
  #   h  #=> { :a => 1 }
  #
  # CREDIT: Daniel Schierbeck

  def delete_unless #:yield:
    delete_if{ |key, value| ! yield(key, value) }
  end

end

