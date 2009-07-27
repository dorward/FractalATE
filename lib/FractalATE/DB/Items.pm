package FractalATE::DB::Items;
use strict;
use warnings;

use DBIx::Class;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/PK::Auto Core/);
__PACKAGE__->table('items');
__PACKAGE__->add_columns(
    item_id => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
    },
            name => {
                data_type => 'text',
                is_nullable => 0,
            },
);
 
__PACKAGE__->set_primary_key('item_id');
__PACKAGE__->add_unique_constraint([ qw/name/ ]);

__PACKAGE__->has_many(item_tags => 'FractalATE::DB::ItemTagBridges', { 'foreign.item_id' => 'self.item_id' });
__PACKAGE__->many_to_many(tags => 'item_tags', 'tags');

__PACKAGE__->has_many(item_aspects => 'FractalATE::DB::ItemTagBridges', { 'foreign.item_id' => 'self.item_id' });
__PACKAGE__->many_to_many(aspects => 'item_aspects', 'aspects');


1;
