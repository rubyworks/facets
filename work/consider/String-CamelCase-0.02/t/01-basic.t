
use strict;
use warnings;
use Test::More tests => 4;
use String::CamelCase qw(camelize decamelize wordsplit);

# basics.
is(camelize("some_keyword"),  'SomeKeyword');
is(decamelize("SomeKeyword"), 'some_keyword');
is_deeply([wordsplit("some_keyword")], [qw(some keyword)]);
is_deeply([wordsplit("SomeKeyword")],  [qw(Some Keyword)]);

# -----------------------------------------------------------------------------
# End of File.
# -----------------------------------------------------------------------------
