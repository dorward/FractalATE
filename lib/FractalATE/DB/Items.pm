package FractalATE::DB::Items;
use strict;
use warnings;

use DBIx::Class;
use base qw/DBIx::Class/;
#use Crypt::Skip32::Base32Crockford;

#my $key = pack( 'H20', "DA41DD04111A4D" );
#my $cipher = Crypt::Skip32::Base32Crockford->new($key);

__PACKAGE__->load_components(qw/PK::Auto Core/);
__PACKAGE__->table('items');
__PACKAGE__->add_columns(
    item_id => {
        data_type         => 'integer',
        is_nullable       => 0,
        is_auto_increment => 1,
    },
    name => {
        data_type   => 'text',
        is_nullable => 0,
    },
);

__PACKAGE__->set_primary_key('item_id');
__PACKAGE__->add_unique_constraint( [qw/name/] );

__PACKAGE__->has_many(
    item_tags => 'FractalATE::DB::ItemTagBridges',
    { 'foreign.item_id' => 'self.item_id' }
);
__PACKAGE__->many_to_many( tags => 'item_tags', 'tags' );

__PACKAGE__->has_many(
    item_aspects => 'FractalATE::DB::ItemAspectBridges',
    { 'foreign.item_id' => 'self.item_id' }
);
__PACKAGE__->many_to_many( aspects => 'item_aspects', 'aspect' );

# inflate is not supported for searches. Write a ruleset method.
# __PACKAGE__->inflate_column(
#     'item_id',
#     {
#         inflate => sub {
#             my $token = shift;
#             my $value = $cipher->encrypt_number_b32_crockford($token);
#             warn $token, " changed to ", $value, "\n";
#             return $value;
#         },
#         deflate => sub {
#             my $token = shift;
#             my $value = $cipher->decrypt_number_b32_crockford($token);
#             warn $token, " changed to ", $value, "\n";
#             return $value;
#         },
#     }
# );
# 
1;
