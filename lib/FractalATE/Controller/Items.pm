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

sub specific_item : PathPart('') Chained('items') CaptureArgs(1) {
    my ( $self, $c, $item_id ) = @_;
    my $item = $c->stash->{items}->find({ item_id => $item_id });
      die "No such item" if(!$item);
      $c->stash(item => $item);
}

sub view : Chained('specific_item') PathPart('') Args(0) {
    # This just shows the item. Everything needed for this is in the specific_item part of the chain    
}

sub edit : Chained('specific_item') PathPart('edit') Args(0) {
        my ( $self, $c, $item_id ) = @_;

    # Normally we just view the item with the edit template.
    # If we are processing post data then we either have an error case
    #   when we will put the data back in the template with error messages
    #   or we will accept it and redirect to the view for the item.
    
    if (lc $c->req->method eq 'post') {
        my $item = $c->stash->{item};
        my $params = $c->req->params;
        # TODO: Sanity check this data!
        my $name = $params->{name};
        $item->update({
            name => $name
        });
        
    }
}


=head1 AUTHOR

David Dorward

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
