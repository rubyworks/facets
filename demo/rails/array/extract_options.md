## Array#extract_options!

    require 'facets/array/extract_options'

Extracts options from a set of arguments. Removes and returns the last
element in the array if it's a hash, otherwise returns a blank hash.

    def options(*args)
      args.extract_options!
    end

    options(1, 2).assert           == {}
    options(1, 2, :a => :b).assert == {:a=>:b}
