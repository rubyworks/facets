## Exception#detail

    require 'facets/exception/detail'

Provides a more detailed error message.

    begin
      raise ArgumentError
    rescue ArgumentError => err
      r = err.detail
      r.assert.include?('ArgumentError')
    end

The output of `#detail` looks something like this:

    ArgumentError: ArgumentError
      example.rb:4:in `<main>'
      LOGGED FROM: example.rb:6:in `rescue in <main>'

