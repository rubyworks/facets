## Binding#[]

    require 'facets/binding/op'

    a = 1
    b = 2
    x = "hello"

    binding["x"].assert == "hello"

## Binding#[]=

    binding["x"] = "goodbye"

    binding["x"].assert == "goodbye"

