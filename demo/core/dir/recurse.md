## Dir#recurse

Given a directory 'recurse' containing:

    A.txt
    A/B.txt
    A/B/C.txt

We can use #recurse to gather a complete recursive
list of all the entries.

    require 'facets/dir/recurse'

    x = %w{
      recurse/A
      recurse/A.txt
      recurse/A/B
      recurse/A/B.txt
      recurse/A/B/C.txt
    }.sort

    r = Dir.recurse('recurse').sort

    r.assert == x

## Dir#ls_r

Dir#ls_r is an alias for #recurse which can also be used to gather
a complete recursive list of all the entries.

    x = %w{
      recurse/A
      recurse/A.txt
      recurse/A/B
      recurse/A/B.txt
      recurse/A/B/C.txt
    }.sort

    r = Dir.ls_r('recurse').sort

    r.assert == x
