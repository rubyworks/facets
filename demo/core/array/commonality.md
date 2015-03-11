## Array#commonality

    require 'facets/array/commonality'

Get a list of all items that have something in common in terms of the
supplied block. If no block is given objects are considered to be in
common if they return the same value for Object#hash and if obj1 == obj2.

This can be useful, for instance, in determining all persons that share
their last name with another person.

    Person = Struct.new(:name)
    persons = %w{Wayne Pennyworth Grayson Wayne Pennyworth}.map{|n| Person.new(n)}
    persons.commonality { |person| person.name }.keys # => ["Wayne","Pennyworth"]

The method is similar to #group_by which is a standard Ruby method as of 1.9.
To get effectively the same results with #group_by use `select{ |k,v| v.size > 1 }`.

    expected = { 2 => [2, 2], 4 => [4, 4] }

    [1, 2, 2, 3, 4, 4].group_by{ |e| e }.
                       select{ |k,v| v.size > 1 }.assert == expected

    [1, 2, 2, 3, 4, 4].commonality.assert == expected


    %w{foo bar baz}.commonality{|str| str[0]}.assert == {'b' =>["bar", "baz"] }

Returns a Hash mapping common attribute to those elements.


