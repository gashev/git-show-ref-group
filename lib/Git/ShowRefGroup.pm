package Git::ShowRefGroup;
use strict;
use warnings;

{
    $Git::ShowRefGroup::VERSION = '0.001';
}


use Git::Repository;

use base qw(Class::Accessor);
Git::ShowRefGroup->mk_accessors(qw(work_tree));

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
}

sub run {
    my $self = shift;
    my $commit;
    my $ref;
    my $refs = {};

    my $repository = Git::Repository->new(work_tree => $self->work_tree);

    for my $line ($repository->run('show-ref')) {
        ($commit, $ref) = split ' ', $line;
        push @{$refs->{$commit}}, $ref;
    }

    for $commit (sort keys %{$refs}) {
        printf "%s %s\n", $commit, join(' ', @{$refs->{$commit}});
    }
}

1;

#################### main pod documentation begin ###################

=head1 NAME

Git::ShowRefGroup - Displays references available in a local repository along
with the associated commit IDs group by IDs.

=head1 SYNOPSIS

  git-show-ref-groups

=head1 DESCRIPTION

Displays references available in a local repository along with the associated
commit IDs. Results can be filtered using a pattern and tags can be dereference
into object IDs. Additionally, it can be used to test whether a particular ref
exists.

=head1 USAGE



=head1 BUGS



=head1 SUPPORT



=head1 AUTHOR

    Oleg Gashev
    gashev@gmail.com

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with
this module.

=head1 SEE ALSO

perl(1).

=cut

#################### main pod documentation end ###################

