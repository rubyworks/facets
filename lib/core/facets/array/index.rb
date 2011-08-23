class Array

  if RUBY_VERSION < '1.8.7'

    alias_method :_facets_index, :index

    # Allows #index to accept a block.
    #
    #   ['a', 'b', 'c'].index{ |x| x.upcase == 'C' } #=> 2
    #
    # IMPORTANT: This is one of the few core overrides in Facets.
    def index(obj=nil, &block)
      if block_given?
        _facets_index(find(&block))
      else
        _facets_index(obj)
      end
    end

  end

end

