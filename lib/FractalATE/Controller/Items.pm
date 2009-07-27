package FractalATE::Controller::Items;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

FractalATE::Controller::Items - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $items = $c->model('DB')->resultset('Items');
    $c->stash(items => $items);
}


=head1 AUTHOR

David Dorward

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
