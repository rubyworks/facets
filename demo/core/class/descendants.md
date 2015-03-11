## Class#descendants

    require 'facets/class/descendants'

The `Class#descendants` method returns a list of classes that are subclasses
of a class.

    a = Class.new
    b = Class.new(a)
    c = Class.new(b)

    a.descendants.assert == [b,c]

