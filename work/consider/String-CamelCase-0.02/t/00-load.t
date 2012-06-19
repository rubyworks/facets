#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'String::CamelCase' );
}

diag( "Testing String::CamelCase $String::CamelCase::VERSION, Perl $], $^X" );
