## Array#**

    require 'facets/array/op_pow'

Alias for Array#product

NOTE: This method is not a common core extension and is not loaded automatically
when using ```require 'facets'```

    ([1,2] ** [3,4]).assert == [[1, 3], [1, 4], [2, 3], [2, 4]]
