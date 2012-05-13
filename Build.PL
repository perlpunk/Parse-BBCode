use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
    create_makefile_pl => 'traditional',
    license            => 'perl',
    module_name        => 'Parse::BBCode',
    dist_author        => 'Tina Mueller',
    requires => {
        'URI::Escape' => 0,
        Carp           => 0,
        strict         => 0,
        warnings       => 0,
        'Class::Accessor::Fast' => 0.25,
        perl => '5.6.1',
    },
    build_requires => {
        'Test::More'          => 0,
        'Test::NoWarnings'    => 0,
        'Module::Build'       => 0.28,
    },
    configure_requires => {
        'Module::Build'       => 0.28,
    },
    recommends         => {
    },
    create_readme      => 1,
    sign               => 1,
    meta_merge => {
        resources => {
            license     => 'http://dev.perl.org/licenses/',
            repository  => 'https://github.com/perlpunk/Parse-BBCode',
        },
    },
);
$build->create_build_script;
