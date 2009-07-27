package FractalATE::DB::Tags;
use strict;
use warnings;

use DBIx::Class;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/PK::Auto Core/);
__PACKAGE__->table('tags');
__PACKAGE__->add_columns(
    tag_id => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
    },

            tag => {
                data_type => 'text',
                is_nullable => 0
            },
);
 
__PACKAGE__->set_primary_key('tag_id');
__PACKAGE__->add_unique_constraint([ qw/tag/ ]);

__PACKAGE__->has_many(item_tags => 'FractalATE::DB::ItemTagBridges', { 'foreign.tag_id' => 'self.tag_id' });
__PACKAGE__->many_to_many(items => 'item_tags', 'items');


1;
