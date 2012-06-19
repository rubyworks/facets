## ----------------------------------------------------------------------------
# String::CamelCase
# -----------------------------------------------------------------------------
# Mastering programmed by YAMASHINA Hio
#
# Copyright 2006 YAMASHINA Hio
# -----------------------------------------------------------------------------
# $Id$
# -----------------------------------------------------------------------------
package String::CamelCase;

use warnings;
use strict;

our $VERSION = '0.02';

use base qw(Exporter);
our @EXPORT_OK = qw(camelize decamelize wordsplit);

1;

sub wordsplit
{
	my $s = shift;
	split( /[_\s]+|\b|(?<![A-Z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])/, $s );
}

sub camelize
{
	my $s = shift;
	join('', map{ ucfirst $_ } split(/(?<=[A-Za-z])_(?=[A-Za-z])|\b/, $s));
}

sub decamelize
{
	my $s = shift;
	$s =~ s{([^a-zA-Z]?)([A-Z]*)([A-Z])([a-z]?)}{
		my $fc = pos($s)==0;
		my ($p0,$p1,$p2,$p3) = ($1,lc$2,lc$3,$4);
		my $t = $p0 || $fc ? $p0 : '_';
		$t .= $p3 ? $p1 ? "${p1}_$p2$p3" : "$p2$p3" : "$p1$p2";
		$t;
	}ge;
	$s;
}

__END__

=head1 NAME

String::CamelCase - camelcase, de-camelcase

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

 use String::CamelCase qw(camelize decamelize wordsplit);
 print camelize("some_keyword");  # ==> SomeKeyword
 print decamelize("SomeKeyword"); # ==> some_keyword
 print wordsplit("some_keyword"); # ==> (some, keyword)
 print wordsplit("SomeKeyword");  # ==> (Some, Keyword)

=head1 EXPORT

This module can export two functions, C<camelize> and C<decamelize>.

=head1 FUNCTIONS

=head2 camelize($under_score)

convert from under_score text to CamelCase one.

=head2 decamelize($CamelCase)

convert from CamelCase text to under_score one.

=head2 wordsplit($str)

=head1 AUTHOR

YAMASHINA Hio, C<< <hio at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-string-camelcase at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=String-CamelCase>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc String::CamelCase

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/String-CamelCase>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/String-CamelCase>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=String-CamelCase>

=item * Search CPAN

L<http://search.cpan.org/dist/String-CamelCase>

=back

=head1 SEE ALSO

CamelCase(en.wikipedia.org) L<http://en.wikipedia.org/wiki/CamelCase>

CamelCase(ja.wikipedia.org) L<http://ja.wikipedia.org/wiki/%E3%82%AD%E3%83%A3%E3%83%A1%E3%83%AB%E3%82%B1%E3%83%BC%E3%82%B9>

=head1 COPYRIGHT & LICENSE

Copyright 2006 YAMASHINA Hio, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

# -----------------------------------------------------------------------------
# End of File.
# -----------------------------------------------------------------------------
