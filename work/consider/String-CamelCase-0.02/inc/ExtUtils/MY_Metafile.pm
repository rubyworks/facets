## ----------------------------------------------------------------------------
#  ExtUtils::MY_Metafile
# -----------------------------------------------------------------------------
# Mastering programmed by YAMASHINA Hio
#
# Copyright 2006-2008 YAMASHINA Hio
# -----------------------------------------------------------------------------
# $Id: MY_Metafile.pm 5362 2008-01-30 05:09:42Z hio $
# -----------------------------------------------------------------------------
package ExtUtils::MY_Metafile;
use strict;
#use warnings; # warnings pragma was first released with perl 5.006.
use ExtUtils::MakeMaker;

use vars qw($VERSION @EXPORT);

$VERSION = '0.09';
@EXPORT = qw(my_metafile);

use vars qw(%META_PARAMS); # DISTNAME(pkgname)=>HASHREF.

use vars qw($DEFAULT_META_SPEC_VERSION);
$DEFAULT_META_SPEC_VERSION = '1.3';

1;

# -----------------------------------------------------------------------------
# for: use inc::ExtUtils::MY_Metafile;
#
sub inc::ExtUtils::MY_Metafile::import
{
	my $pkg = 'ExtUtils::MY_Metafile';
	push(@inc::ExtUtils::MY_Metafile::ISA, $pkg);
	goto &import;
}

# -----------------------------------------------------------------------------
# import.
#
sub import
{
	my $pkg = shift;
	my @syms = (!@_ || grep{/^:all$/}@_) ? @EXPORT : @_;
	my $callerpkg = caller;
	
	foreach my $name (@syms)
	{
		my $sub = $pkg->can($name);
		$sub or next;
		no strict 'refs';
		*{$callerpkg.'::'.$name} = $sub;
	}
	if( !grep{ /^:no_setup$/ } @_ )
	{
		# override.
		*MM::metafile_target = \&_mm_metafile;
	}
}

# -----------------------------------------------------------------------------
# _diag_version();
#
sub _diag_version
{
	my $mmver = $ExtUtils::MakeMaker::VERSION;
	my $mmvernum = $mmver;
	if( $mmvernum =~ /^(\d+)\.(\d+)_(\d+)\z/ )
	{
	  $mmvernum = "$1.$2$3";
	  $mmver .= "=$mmvernum";
	}
	if( $mmvernum >= 6.30 )
	{
		print STDERR "# ExtUtils::MY_Metafile for MM 6.30 or later ($mmver).\n";
	}else
	{
		print STDERR "# ExtUtils::MY_Metafile for MM 6.25 or earlier ($mmver).\n";
	}
}

# -----------------------------------------------------------------------------
# my_metafile($distname => $param);
# my_metafile($param);
#
sub my_metafile
{
	my $distname = @_>=2 && shift;
	my $param    = shift;
	UNIVERSAL::isa($distname,'HASH') and $distname = $distname->{DISTNAME};
	$distname ||= '';
	$distname =~ s/::/-/g;
	$META_PARAMS{$distname} and warn "# overwrite previous meta config $distname.\n";
	$META_PARAMS{$distname} = $param;
}

# -----------------------------------------------------------------------------
# _mm_metafile($MM)
#  altanative of MM::metafile_target.
#  takes $MM object and returns makefile text.
#
sub _mm_metafile
{
	my $this = shift;
	
	if( $this->{NO_META} )
	{
		return
			"metafile:\n" .
			"\t\$(NOECHO) \$(NOOP)\n";
	}
	
	# generate META.yml text.
	#
	my $meta = _gen_meta_yml($this);
	my @write_meta = (
		'$(NOECHO) $(ECHO) Generating META.yml',
		$this->echo($meta, 'META_new.yml'),
	);
	
	# format as makefile text.
	#
	my ($make_target, $metaout_file);
	my $mmvernum = $ExtUtils::MakeMaker::VERSION;
	if( $mmvernum =~ /^(\d+)\.(\d+)_(\d+)\z/ )
	{
	  $mmvernum = "$1.$2$3";
	}
	if( $mmvernum >= 6.30 )
	{
		$make_target  = "# for MM 6.30 or later.\n";
		$make_target .= "metafile : create_distdir\n";
		$metaout_file = '$(DISTVNAME)/META.yml';
	}else
	{
		$make_target  = "# for MM 6.25 or earlier.\n";
		$make_target .= "metafile :\n";
		$metaout_file  = 'META.yml',
	}
	
	my $rename_meta  = "-\$(NOECHO) \$(MV) META_new.yml $metaout_file";
	my $make_body = join('', map{"\t$_\n"} @write_meta, $rename_meta);
	"$make_target$make_body";
}

# -----------------------------------------------------------------------------
# _gen_meta_yml($MM);
#  generate META.yml text.
#
sub _gen_meta_yml
{
	# from MakeMaker-6.30.
	my $this = shift;
	my $param = shift;
	my $check_meta_spec = 1;
	if( !$param )
	{
		$param = $META_PARAMS{$this->{DISTNAME}} || $META_PARAMS{''};
		if( !$param )
		{
			$param = {};
			$check_meta_spec = 0;
		}
	}
	if( $META_PARAMS{':all'} )
	{
		# special key.
		$param = { %{$META_PARAMS{':all'}}, %$param };
	}

	# meta_spec and meta_spec_version.
	my $meta_spec = $param->{meta_spec} || $param->{'meta-spec'};
	if($param->{meta_spec} && $param->{'meta-spec'} )
	{
		warn "both meta_spec and meta-spec exist.\n";
	}
	$meta_spec &&= {%$meta_spec}; # sharrow-copy.
	$meta_spec ||= {};
	if( exists($param->{meta_spec_version}) && exists($meta_spec->{version}) )
	{
		warn "both meta_spec_vesrion and meta_spec.version exist.\n";
	}
	$meta_spec->{version} ||= $param->{meta_spec_version} || $DEFAULT_META_SPEC_VERSION;
	$meta_spec->{url}     ||= "http://module-build.sourceforge.net/META-spec-v$meta_spec->{version}.html";

	# requires:, build_requires:
	my $requires_to_yaml = sub{
		my $key = shift;
		my $hash = shift;
		my $yaml = '';
		my ($maxkeylen) = sort{$b<=>$a} map{length($_)} keys   %$hash;
		my ($maxvallen) = sort{$b<=>$a} map{length($_)} values %$hash;
		foreach my $name ( sort { lc $a cmp lc $b } keys %$hash )
		{
			my $ver = $hash->{$name};
			$yaml .= sprintf "  %-*s %*s\n", $maxkeylen+1, "$name:", $maxvallen, $ver;
		}
		chomp $yaml;
		$yaml ? "$key:\n$yaml" : '';
	};
	my $requires = $requires_to_yaml->(requires => $param->{requires} || $this->{PREREQ_PM});
	my $build_requires = $requires_to_yaml->(build_requires => $param->{build_requires});
	
	# no_index:
	my $no_index = $param->{no_index};
	if( !$no_index || !$no_index->{directory} )
	{
		my @dirs = grep{-d $_} (qw(
			inc t
			ex eg example examples sample samples demo demos
		));
		$no_index = @dirs && +{ directory => \@dirs };
	}
	$no_index = $no_index ? _yaml_out({no_index=>$no_index}) : '';
	chomp $no_index;
	if( $param->{no_index} && !$ENV{NO_NO_INDEX_CHECK} )
	{
		my $warned;
		foreach my $key (keys %{$param->{no_index}})
		{
			# dir is in spec-v1.2, directory is from spec-v1.3.
			if( $key eq 'dir' && $meta_spec->{version}>=1.3 )
			{
				$warned ||= print STDERR "\n";
				warn "$key should be `directory' in META-spec-v1.3 and later.\n";
				next;
			}
			$key =~ /^(file|dir|directory|package|namespace)$/ and next;
			$warned ||= print STDERR "\n";
			warn "$key is invalid field for no_index.\n";
		}
		$warned and print STDERR "\n";
	}
	
	# abstract is from file.
	my $abstract = '';
	if( $this->{ABSTRACT} )
	{
		$abstract = _yaml_out({abstract => $this->{ABSTRACT}});
	}elsif( $this->{ABSTRACT_FROM} && open(my$fh, "< $this->{ABSTRACT_FROM}") )
	{
		while(<$fh>)
		{
			/^=head1 NAME$/ or next;
			(my $pkg = $this->{DISTNAME}) =~ s/-/::/g;
			while(<$fh>)
			{
				/^=/ and last;
				/^(\Q$pkg\E\s+-+\s+)(.*)/ or next;
				$abstract = $2;
				last;
			}
			last;
		}
		$abstract = $abstract ? _yaml_out({abstract=>$abstract}) : '';
	}
	chomp $abstract;
	
	# build yaml object as hash.
	my $yaml = {}; # key=>"value as yaml-text".

	# first, set from arguments for WriteMakefile().
	$yaml->{name}         = $this->{DISTNAME};
	$yaml->{version}      = $this->{VERSION};
	$yaml->{version_from} = $this->{VERSION_FROM};
	$yaml->{installdirs}  = $this->{INSTALLDIRS};
	$yaml->{author}       = $this->{AUTHOR};
	$yaml->{license}      = $this->{LICENSE};
	foreach my $key (keys %$yaml)
	{
		if( $yaml->{$key} )
		{
			my $pad = ' 'x(12-length($key));
			$yaml->{$key} = sprintf('%s:%s %s', $key, $pad, $yaml->{$key});
		}
	}
	$yaml->{abstract} = $abstract;
	$yaml->{no_index} = $no_index;
	$yaml->{requires} = $requires;
	$yaml->{build_requires} = $build_requires;
	
	$yaml->{distribution_type} = 'distribution_type: module';
	$yaml->{generated_by} = "generated_by: ExtUtils::MY_Metafile version $VERSION, EUMM-$ExtUtils::MakeMaker::VERSION.";

	$yaml->{'meta-spec'}  = "meta-spec:\n";
	$yaml->{'meta-spec'} .= "  version: ".delete($meta_spec->{version})."\n";
	$yaml->{'meta-spec'} .= "  url: ".delete($meta_spec->{url})."\n";

	# next, set from arguments for my_metafile().
	my $extras = {};
	foreach my $key (sort keys %$param)
	{
		grep{$key eq $_} qw(no_index requires build_requires meta_spec meta-spec meta_spec_version) and next;
		my $line = _yaml_out->({$key=>$param->{$key}});
		if( exists($yaml->{$key}) )
		{
			chomp $line;
			$yaml->{$key} = $line;
		}else
		{
			$extras->{$key} = $line;
		}
	}
	$yaml->{extras} = join('', map{$extras->{$_}} sort keys %$extras);

	# then, check required keys by yaml-spec.
	my @required_keys = qw(meta-spec name version abstract author license generated_by);
	foreach my $key (@required_keys)
	{
		$check_meta_spec or next;
		my $ok = $yaml->{$key} && $yaml->{$key}=~/\w/;
		$ok  ||= $extras->{$key} and next;
		warn "$key is required for meta-spec v1.2 ($this->{DISTNAME}).\n";
	}

	if( exists($param->{license}) && exists($this->{LICENSE}) && $param->{license} ne $this->{LICENSE} )
	{
		warn "WriteMakefile.LICENSE ($this->{LICENSE}) is different from my_metafile.license ($param->{license}).";
	}

	$yaml->{license} ||= 'license: unknown';
	foreach my $key (keys %$yaml)
	{
		$key eq 'extras' and next;
		$yaml->{$key} ||= "#$key:";
	}
	$yaml->{extras} &&= "\n# extras.\n$yaml->{extras}";

	foreach my $key (qw(abstract license))
	{
		my $pad = ' 'x(12-length($key));
		$yaml->{$key} =~ s/^$key: +(.+)\z/$key:$pad $1/;
	}

	# packing into singple text.
	my $meta = <<YAML;
# http://module-build.sourceforge.net/META-spec.html
$yaml->{name}
$yaml->{version}
$yaml->{version_from}
$yaml->{installdirs}
$yaml->{author}
$yaml->{abstract}
$yaml->{license}
$yaml->{requires}
$yaml->{build_requires}
$yaml->{no_index}
$yaml->{extras}
$yaml->{distribution_type}
$yaml->{generated_by}
$yaml->{'meta-spec'}
YAML
	#print "$meta";
	$meta;
}

# -----------------------------------------------------------------------------
# generate simple yaml.
#
sub _yaml_out
{
	my $obj   = shift;
	
	my $depth = shift || 0;
	my $out   = '';
	
	if( !defined($obj) )
	{
		$out = "  "x$depth."~\n";
	}elsif( !ref($obj) )
	{
		$out = "  "x$depth.$obj."\n";
	}elsif( ref($obj)eq'ARRAY' )
	{
		my @e = map{_yaml_out->($_, $depth+1)} @$obj;
		@e = map{ "  "x$depth."- ".substr($_, ($depth+1)*2)} @e;
		$out = join('', @e);
		$out ||= "  "x$depth."[]";
	}elsif( ref($obj)eq'HASH' )
	{
		foreach my $k (sort keys %$obj)
		{
			$out .= "  "x$depth."$k:";
			$out .= ref($obj->{$k}) ? "\n"._yaml_out($obj->{$k}, $depth+1) : " $obj->{$k}\n";
		}
		$out ||= "  "x$depth."{}";
	}else
	{
		die "not supported: $obj";
	}
	$out;
}

# -----------------------------------------------------------------------------
# End of Code.
# -----------------------------------------------------------------------------

__END__

=encoding utf8

=for stopwords
  YAMASHINA
	Hio
	ACKNOWLEDGEMENTS
	AnnoCPAN
	CPAN
	EUMM
	META.yml
	RT

=head1 NAME

ExtUtils::MY_Metafile - META.yml customize with ExtUtil::MakeMaker


=head1 VERSION

Version 0.09


=head1 SYNOPSIS

put ExtUtils/MY_Metafile.pm into inc/ExtUtils/MY_Metafile.pm:


  $ mkdir -p inc/ExtUtils
  $ cp `perldoc -l ExtUtils::MY_Metafile` inc/ExtUtils/

and write in your Makefile.PL:


  use ExtUtils::MakeMaker;
  use inc::ExtUtils::MY_Metafile;
  
  my_metafile {
    no_index => {
      directory => [ qw(inc example t), ],
    },
    license  => 'perl',
  };
  
  WriteMakefile(
    DISTNAME => 'Your::Module',
    ...
  );

=head1 EXPORT

This module exports one function.


=head1 FUNCTIONS

=head2 my_metafile $modname => \%meta_param;

Takes two arguments.
First one is package name to be generated, and you can omit this 
argument.  Second is hashref which contains META.yml contents.


  my_metafile {
    no_index => {
      directory => [ qw(inc example t), ],
    },
    license  => 'perl',
  };

Some parameters are checked automatically.


=over

=item no_index

If you not specify C<directory> parameter for C<no_index> and
there are any directory of F<inc t ex eg example examples
sample samples demo demos>, they are set as it.


=item requires

C<requires> directive is set from C<PREREQ_PM> parameter
of EUMM. If you want to use C<build_requires>, you can write it.


=back

=head1 AUTHOR

YAMASHINA Hio, C<< <hio at cpan.org> >>


=head1 BUGS

Please report any bugs or feature requests to
C<bug-extutils-my_metafile at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=ExtUtils-MY_Metafile>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.


    perldoc ExtUtils::MY_Metafile

You can also look for information at:


=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/ExtUtils-MY_Metafile>


=item * CPAN Ratings

L<http://cpanratings.perl.org/d/ExtUtils-MY_Metafile>


=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=ExtUtils-MY_Metafile>


=item * Search CPAN

L<http://search.cpan.org/dist/ExtUtils-MY_Metafile>


=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2006-2008 YAMASHINA Hio, all rights reserved.


This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

# -----------------------------------------------------------------------------
# End of File.
# -----------------------------------------------------------------------------
