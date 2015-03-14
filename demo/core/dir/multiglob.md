## Dir#multiglob

Dir#multglob is like Dir#glob but it can handle more than one match
parameter at a time.

Given a directory 'multiglob' containing:

    A.txt
    A/B.txt
    A/B/C.txt

We can use #multglob to find multiple matches.

    require 'facets/dir/multiglob'

    x = %w{
      multiglob/A
      multiglob/A.txt
    }

    r = Dir.multiglob('multiglob/A', 'multiglob/A.*').sort

    r.assert == x

## Dir#multiglob_r

Dir#multiglob_r is like #multiglob but automatically searches
directories recrusively.

    x = %w{
      multiglob/A 
      multiglob/A/B
      multiglob/A.txt
      multiglob/A/B.txt
      multiglob/A/B/C.txt
    }.sort

    r = Dir.multiglob_r('multiglob/*').sort

    r.assert == x

