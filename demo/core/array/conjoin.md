## Array#conjoin

    require 'facets/array/conjoin'

This is more advanced form of #join. It allows for fine control
of separators.

NOTE: The old version used to default its separator to ", " and
default the terminating separator to " and ". This is no longer
the case. You must specifically provide these parameters.

If no parameters are given, it acts like #join but will a space
separator.

    [1,2,3].conjoin.assert == "1 2 3"

Use comma+space and 'and' on tail.

    [1,2,3].conjoin(', ', ' and ').assert == "1, 2 and 3"

Use comma+space and 'or' on tail using :last option.

    [1,2,3].conjoin(', ', :last => ' or ').assert == "1, 2 or 3"

Use semicolon+space and ampersand on tail using index.

    [1,2,3].conjoin('; ', -1 => ' & ').assert == "1; 2 & 3"

Can take a block to determine separator.

    [1,2,3,4].conjoin{ |i, a, b| i % 2 == 0 ? '.' : '-' }.assert == "1.2-3.4"

This makes very esoteric transformation possible.

    [1,1,2,2].conjoin{ |i, a, b| a == b ? '=' : ' != ' }.assert == "1=1 != 2=2"

    [1,2,3,4].conjoin{ |i, x, y| "<#{i} #{x} #{y}>" }.assert == "1<0 1 2>2<1 2 3>3<2 3 4>4"

There are also spacing options. Providing the :space option
pads the separators.

    [1,2,3].conjoin(',', '&', :space=>2).assert == "1  ,  2  &  3"

And the :spacer option can set an alternate spacing string.

    [1,2,3].conjoin('|', '>', :space=>2, :spacer=>'-').assert == "1--|--2-->--3"

