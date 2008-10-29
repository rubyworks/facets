class Array

  if RUBY_VERSION < '1.9'

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


=begin :spec:

  require 'quarry/spec'

  Quarry.spec "Array" do

    the_method "index" do

      finds "an element" do
        i = [1,2,3].index{ |e| e == 2 }
        i.assert == 1
      end

      terminates "when no element is found" do
        i = [1,2,3].index{ |e| e == 5 }
        i.assert == nil
      end

    end

  end

=end

