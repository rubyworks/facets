## Shellwords

    require 'facets/shellwords'

### Hash#shellwords

Turns a hash into command line flags, one word per flag. A one-letter key
gives a short flag and a longer key a long one. A value of `true` gives the
bare flag, and `false` or `nil` leaves the flag out.

    {v: true, debug: true, quiet: false}.shellwords.assert == ['-v', '--debug']

Any other value is joined to its flag with `=`, and an array value repeats
the flag for each element.

    {name: 'jim', I: ['lib', 'test']}.shellwords.assert ==
      ['--name=jim', '-I=lib', '-I=test']

The values aren't quoted. Each flag and its value is one word, ready to pass
to `system(*words)`.

    {name: 'a b'}.shellwords.assert == ['--name=a b']

### Hash#shelljoin

Escapes the flags and joins them into one string for a shell.

    {debug: true, name: 'a b'}.shelljoin.assert == '--debug --name\=a\ b'

The shell splits that string back into the same words.

    Shellwords.split('--debug --name\=a\ b').assert == ['--debug', '--name=a b']

### Array#shellwords

Turns an array in the shape of Ruby method arguments, with options in a hash,
into command line words. The flags come first.

    ['a', 'b', {d: true}].shellwords.assert == ['-d', 'a', 'b']

To make a command line, join the words with Ruby's own `Array#shelljoin`.

    ['a b', {name: 'jim'}].shellwords.shelljoin.assert == '--name\=jim a\ b'

`Array#shelljoin` itself is Ruby's. It escapes each element as one word and
doesn't turn hashes into flags, since a value meant as one argument must
never become several.
