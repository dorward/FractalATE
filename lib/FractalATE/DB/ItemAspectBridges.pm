package FractalATE::DB::ItemAspectBridges;

use strict;
use warnings;
use DBIx::Class;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/PK Core/);
__PACKAGE__->table('item_aspect_bridges');
__PACKAGE__->add_columns(
    item_id => {
        data_type   => 'integer',
        is_nullable => 0,
    },
    aspect_id => {
        data_type   => 'integer',
        is_nullable => 0,
    },

);

__PACKAGE__->set_primary_key(qw(item_id aspect_id));
__PACKAGE__->belongs_to( 'item', 'FractalATE::DB::Items',
    { 'foreign.item_id' => 'self.item_id' } );
__PACKAGE__->belongs_to( 'aspect', 'FractalATE::DB::Aspects',
    { 'foreign.aspect_id' => 'self.aspect_id' } );
1;

=head1 NAME

FractalATE::DB::ItemAspectBridges - DBIc bridging table

=head1 FIELDS

=item item_id

Link to L<FractalATE::DB::Items>

=item aspect_id

Link to L<FractalATE::DB::Aspects>

=head1 AUTHOR

David Dorward - L<http://dorward.me.uk/>

=head1 SEE ALSO

=item L<DBIx::Class::Schema>

Schema that uses this module

=item L<DBIx::Class::Manual>

Full documentation for DBIc

=back

=cut
