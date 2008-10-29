require "facets/hash/except"

class Hash

  unless defined?(::ActiveSupport)  # ActiveSupport

    # Returns a new hash with only the given keys.

    def slice(*keep_keys)
      h = {}
      keep_keys.each do |key|
        h[key] = fetch(key)
      end
      h
    end

    # Replaces hash with a new hash having only the given keys.
    # This return the hash of keys removed.
    #
    #   h = {:a=>1, :b=>2}
    #   h.slice!(:a)  #=> {:a=>1}
    #   h             #=> {:b=>2}
    #
    def slice!(*keep_keys)
      removed = except(*keep_keys)
      replace(slice(*keep_keys))
      removed
    end

  end

end

