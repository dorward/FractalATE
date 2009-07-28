package FractalATE::Controller::Aspects;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

FractalATE::Controller::Aspects - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub aspects : PathPart('aspects') Chained('/') CaptureArgs(0) {

    # All actions in this controller will use the Aspects result set, so we will
    # pop it on the stash here.
    my ( $self, $c, $integer ) = @_;
    my $aspects = $c->model('DB')->resultset('Aspects');
    $c->stash( aspects => $aspects );
}

sub index : PathPart('') Chained('aspects') Args(0) {

    # Default action - lists aspects
}

sub specific_aspect : PathPart('') Chained('aspects') CaptureArgs(1) {

    # Gets data for a specific aspect
    my ( $self, $c, $aspect_id ) = @_;
    my $aspect = $c->stash->{aspects}->find( { aspect_id => $aspect_id } );
    die "No such aspect" if ( !$aspect );
    $c->stash( aspect => $aspect );
}

sub view : Chained('specific_aspect') PathPart('') Args(0) {

# This just shows the aspect. Everything needed for this is in the specific_aspect part of the chain
}

sub edit : Chained('specific_aspect') PathPart('edit') Args(0) {

    # Allow an aspect to be edited
    my ( $self, $c ) = @_;

    # Normally we just view the aspect with the edit template.
    # If we are processing post data then we either have an error case
    #   when we will put the data back in the template with error messages
    #   or we will accept it and redirect to the view for the aspect.

    if ( lc $c->req->method eq 'post' ) {
        my $params = $c->req->params;
        my $aspect_o   = $c->stash->{aspect};

        # TODO: Sanity check this data! And do it in a sub so it can be reused!
        my $aspect = $params->{aspect};
        $aspect_o->update( { aspect => $aspect } );

        return $c->res->redirect(
            $c->uri_for_action( 'aspects/view', $c->req->captures ) );
    }
}

sub add : Chained('aspects') PathPart('add') Args(0) {
    my ( $self, $c ) = @_;
    if ( lc $c->req->method eq 'post' ) {
        my $params = $c->req->params;
        my $aspects = $c->stash->{aspects};
        # TODO: Sanity check this data! And do it in a sub so it can be reused!
        my $aspect = $params->{aspect};
        my $aspect_o = $aspects->create({ aspect => $aspect });
        return $c->res->redirect(
            $c->uri_for_action( 'aspects/view', [ $aspect_o->aspect_id ] ) );
    } else {
        # Share a template with edit
        $c->stash->{template} = 'aspects/edit.tt';
    }
}

=head1 AUTHOR

David Dorward

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
