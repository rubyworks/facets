use strict;
use warnings;
use ExtUtils::MakeMaker;
use inc::ExtUtils::MY_Metafile qw(my_metafile);

my_metafile {
  no_index => {
    directory => [ qw(inc t), ],
  },
  license  => 'perl',
};

WriteMakefile(
    NAME                => 'String::CamelCase',
    AUTHOR              => 'YAMASHINA Hio <hio@cpan.org>',
    VERSION_FROM        => 'lib/String/CamelCase.pm',
    ABSTRACT_FROM       => 'lib/String/CamelCase.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'String-CamelCase-*' },
);
