class Array

  # CORE OVERRIDE

  if RUBY_VERSION < '1.8.7'

    alias_method :_facets_index, :index

    # Allows #index to accept a block.
    #
    # OVERRIDE! This is one of the bery few core
    # overrides in Facets.
    #
    def index(obj=nil, &block)
      if block_given?
        _facets_index(find(&block))
      else
        _facets_index(obj)
      end
    end

  end

end

