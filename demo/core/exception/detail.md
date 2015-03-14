## Exception#detail

    require 'facets/exception/detail'

Provides a more detailed error message.

    begin
      raise ArgumentError
    rescue ArgumentError => err
      e = 
      r = err.detail
      r.assert == e
    end

