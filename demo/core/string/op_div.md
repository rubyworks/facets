## String#op_div

    require 'facets/string/op_div'

Treats +self+ and +path+ as representations of pathnames, joining thme together
as a single path.

    ('merb' / 'string').assert == "merb/string"
    ('merb' / :symbol).assert == "merb/symbol"

