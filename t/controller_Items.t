use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'FractalATE' }
BEGIN { use_ok 'FractalATE::Controller::Items' }

ok( request('/items')->is_success, 'Request should succeed' );


