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

sub items : PathPart('items') Chained('/') CaptureArgs(0) {
    my ( $self, $c, $integer ) = @_;
    my $items = $c->model('DB')->resultset('Items');
    $c->stash( items => $items );
}

sub index : PathPart('') Chained('items') Args(0) {
    my ( $self, $c, $integer ) = @_;
}

sub view : PathPart('') Chained('items') Args(1) {
    my ( $self, $c, $item_id ) = @_;
    my $item = $c->stash->{items}->find({ item_id => $item_id });
      die "No such item" if(!$item);

      $c->stash(item => $item);}

#sub base : Chained('/') PathPart('/items') CaptureArgs(1) {
#    my ( $self, $c ) = @_;
#
#    print 'xxx';
#    my $items = $c->model('DB')->resultset('Items');
#    $c->stash(items => $items);
#}

#  sub view : Chained('base'): PathPart(''): CaptureArgs(1) {
#      my ($self, $c, $item_id) = @_;
#
#      my $item = $c->stash->{items}->find({ item_id => $item_id },
#                                             { key => 'primary' });
#
#      #die "No such item" if(!$item);
#
#      $c->stash(item => $item_id);
#  }

=head1 AUTHOR

David Dorward

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
