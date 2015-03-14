## Dir#descend

    require 'facets/dir/descend'

Descend thru a file path.

    path = 'A/B/C'

    tmp = []

    Dir.descend(path) do |d|
      tmp << d
    end

    tmp.assert == %w{A A/B A/B/C}

