use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name => 'Catmandu::DBI',
    dist_version_from => 'lib/Catmandu/DBI.pm',
    dist_author => [
        'Nicolas Franck <nicolas.franck@ugent.be>',
        'Patrick Hochstenbach <patrick.hochstenbach@ugent.be>',
        'Nicolas Steenlant <nicolas.steenlant@ugent.be>',
        'Vitali Peil <vitali.peil@uni-bielefeld.de>'
    ],
    license => 'perl',
    create_makefile_pl => 'traditional',
    create_license => 1,
    build_requires => {
        'Test::Exception' => 0,
        'Test::More' => 0,
    },
    requires => {
        'perl' => '5.10.1',
        'Catmandu' => '0.2003',
        'namespace::clean' => '0.24',
        'DBI'  => '1.630' ,
        'Moo'  => '1.000003'
    },
    meta_merge => {
        resources => {
            repository => 'https://github.com/LibreCat/Catmandu-DBI.git',
            bugtracker => 'htps://github.com/LibreCat/Catmandu-DBI/issues',
            homepage => 'https://github.com/LibreCat/Catmandu-DBI',
        },
    }
);

$builder->create_build_script;
