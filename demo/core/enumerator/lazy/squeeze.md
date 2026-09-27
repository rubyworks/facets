## Enumerator::Lazy#squeeze

    require 'facets/enumerator/lazy/squeeze'

Provides a lazy version of `Enumerable#squeeze`, collapsing consecutive
duplicates while preserving lazy enumeration.

    enum = [1, 2, 2, 3, 3, 2, 1].lazy.squeeze
    enum.to_a.assert == [1, 2, 3, 2, 1]

Pass values to squeeze only matching entries.

    enum = [1, 2, 2, 3, 3, 2, 1].lazy.squeeze(3)
    enum.to_a.assert == [1, 2, 2, 3, 2, 1]
