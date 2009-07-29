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

    # All actions in this controller will use the Items result set, so we will
    # pop it on the stash here.
    my ( $self, $c, $integer ) = @_;
    my $items = $c->model('DB')->resultset('Items');
    $c->stash( items => $items );
}

sub index : PathPart('') Chained('items') Args(0) {

    # Default action - lists items
}

sub specific_item : PathPart('') Chained('items') CaptureArgs(1) {

    # Gets data for a specific item
    my ( $self, $c, $item_id ) = @_;
    my $item = $c->stash->{items}->find( { item_id => $item_id } );
    die "No such item" if ( !$item );
    $c->stash( item => $item );
}

sub view : Chained('specific_item') PathPart('') Args(0) {

# This just shows the item. Everything needed for this is in the specific_item part of the chain
}

sub edit : Chained('specific_item') PathPart('edit') Args(0) {

    # Allow an item to be edited
    my ( $self, $c ) = @_;

    # Normally we just view the item with the edit template.
    # If we are processing post data then we either have an error case
    #   when we will put the data back in the template with error messages
    #   or we will accept it and redirect to the view for the item.

    if ( lc $c->req->method eq 'post' ) {
        my $params = $c->req->params;
        my $item = create_or_update_item( $self, $c );
        return $c->res->redirect(
            $c->uri_for_action( 'items/view', $c->req->captures ) );
    }
}

sub add : Chained('items') PathPart('add') Args(0) {
    my ( $self, $c ) = @_;
    if ( lc $c->req->method eq 'post' ) {
        my $item = create_or_update_item( $self, $c );
        return $c->res->redirect(
            $c->uri_for_action( 'items/view', [ $item->item_id ] ) );
    }
    else {

        # Share a template with edit
        $c->stash->{template} = 'items/edit.tt';
    }
}

sub create_or_update_item {
    my ( $self, $c ) = @_;

    my $params = $c->req->params;
    my $items  = $c->stash->{items};
    my $item   = $c->stash->{item};

    # TODO: Sanity check this data! And do it in a sub so it can be reused!
    my $name    = $params->{name};
    my @aspects = @{ $params->{aspect} };
    use Data::Dump qw/ddx/;
    @aspects = map { aspect => $_ },
      grep { defined $_ && $_ !~ /^\s*$/ } @aspects;

    my %data = ( name => $name );
    if ($item) {
        $data{item_id} = $item->item_id;
    }

    $item = $items->update_or_create( \%data );
    $item->set_aspects( \@aspects );
    return $item;
}

=head1 AUTHOR

David Dorward

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
