## FileTest#root?

    require 'facets/filetest/root'

Returns true if the given directory is the file system root.
Obviously on a Linux system them means `/`.

    FileTest.assert.root?('/')

Anything else will return false.

    FileTest.refute.root?('/home')

