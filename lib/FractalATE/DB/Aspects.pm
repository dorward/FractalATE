package FractalATE::DB::Aspects;
use strict;
use warnings;

use DBIx::Class;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/PK::Auto Core/);
__PACKAGE__->table('aspects');
__PACKAGE__->add_columns(
    aspect_id => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
    },
    aspect => {
                data_type => 'text',
                is_nullable => 0
    },
);
 
__PACKAGE__->set_primary_key('aspect_id');
__PACKAGE__->add_unique_constraint([ qw/aspect/ ]);

__PACKAGE__->has_many(item_aspects => 'FractalATE::DB::ItemAspectBridges', { 'foreign.aspect_id' => 'self.aspect_id' });
__PACKAGE__->many_to_many(items => 'item_aspects', 'item');

1;
