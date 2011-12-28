class Hash

  # Iterate over hash updating just the keys.
  #
  #   h = {:a=>1, :b=>2}
  #   h.update_keys{ |k| "#{k}!" }
  #   h  #=> { "a!"=>1, "b!"=>2 }
  #
  # @author Trans
  # @author Evgeniy Dolzhenko (bug fix)

  def update_keys #:yield:
    if block_given?
      keys.each { |old_key| store(yield(old_key), delete(old_key)) }
    else
      to_enum(:update_keys)
    end
  end

end

