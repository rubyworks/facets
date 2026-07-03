## Hash#fetch_nested

    require 'facets/hash/fetch_nested'

Fetches a nested value by walking a series of keys. If any key is missing,
`nil` is returned instead of raising `KeyError`.

    data = {'hello' => {'world' => 42}}
    data.fetch_nested('hello', 'world').assert == 42

    data.fetch_nested('hello', 'missing').assert == nil

When a block is given, it is called with the requested keys when the nested
path cannot be fetched.

    fallback = data.fetch_nested('hello', 'missing') { |*keys| keys.join('.') }
    fallback.assert == 'hello.missing'
