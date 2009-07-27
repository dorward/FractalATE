package FractalATE::DB::ItemTagBridges;

use strict;
use warnings;
use DBIx::Class;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/PK Core/);
__PACKAGE__->table('item_tag_bridges');
__PACKAGE__->add_columns(
		item_id => {
			data_type => 'integer',
			is_nullable => 0,
        },
		tag_id => {
			data_type => 'integer',
			is_nullable => 0,
        },
		
	);

__PACKAGE__->set_primary_key(qw(item_id tag_id));
__PACKAGE__->belongs_to('item', 'FractalATE::DB::Items',   { 'foreign.item_id' => 'self.item_id' } );
__PACKAGE__->belongs_to('tag',  'FractalATE::DB::Tags',    { 'foreign.tag_id'  => 'self.tag_id'  } );
1;
=head1 NAME

FractalATE::DB::ItemTagBridges - DBIc bridging table

=head1 FIELDS

=item item_id

Link to L<FractalATE::DB::Items>

=item Tag_id

Link to L<FractalATE::DB::Tags>

=head1 AUTHOR

David Dorward - L<http://dorward.me.uk/>

=head1 SEE ALSO

=item L<DBIx::Class::Schema>

Schema that uses this module

=item L<DBIx::Class::Manual>

Full documentation for DBIc

=back

=cut