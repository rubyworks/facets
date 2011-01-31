class Hash

  # Iterate over hash updating just the values.
  #
  #   h = {:a=>1, :b=>2}
  #   h.update_values{ |v| v + 1 }
  #   h  #=> { :a=>2, :b=>3 }
  #
  # CREDIT: Trans

  def update_values #:yield:
    if block_given?
      each{ |k,v| store(k, yield(v)) }
    else
      to_enum(:update_values)
    end
  end

end

