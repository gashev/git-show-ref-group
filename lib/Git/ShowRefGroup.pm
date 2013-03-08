package Git::ShowRefGroup;

use strict;
use warnings;

our $VERSION = '0.001';

use Git::Repository::Command;

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
    my $command = Git::Repository::Command->new('show-ref', @_);
    my $fhStdout = $command->stdout();
    my $fhStderr = $command->stderr();

    for my $line (<$fhStdout>) {
        ($commit, $ref) = split ' ', $line;
        push(@{$refs->{$commit}}, ((defined $ref) ? $ref : ''));
    }

    for $commit (keys %{$refs}) {
        printf "%s %s\n", $commit, join(' ', @{$refs->{$commit}});
    }

    print STDERR <$fhStderr>;
    $command->close();

    return ($command->exit());
}

1;

__END__

=head1 NAME

Git::ShowRefGroup - Displays references available in a local repository along
with the associated commit IDs group by IDs.

=head1 DESCRIPTION

See L<git-show-ref-group>

=head1 METHODS

=over

=item new()

Creates a new Git::ShowRefGroup object.

=back

=over

=item run(@options)

Execute git-show-ref with options @options. Parse output of git-show-ref and
displays references available in a local repository along with the associated
commit IDs group by IDs.

=back

=head1 AUTHOR

    Oleg Gashev
    gashev@gmail.com

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

The full text of the license can be found in the LICENSE file included with
this module.

=head1 SEE ALSO

git-show-ref(1).

=cut

