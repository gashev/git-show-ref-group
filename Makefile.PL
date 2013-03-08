use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Git::ShowRefGroup',
    VERSION_FROM => 'lib/Git/ShowRefGroup.pm', # finds \$VERSION
    AUTHOR       => 'Oleg Gashev <gashev@gmail.com>',
    ABSTRACT     => 'Displays references available in a local repository along with the associated commit IDs group by IDs.',
    PREREQ_PM    => {
        'Git::Repository' => 0,
        'Test::Simple' => 0.44,
    },
);

