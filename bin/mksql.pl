#!/opt/local/bin/perl

use strict;
use warnings;
use Carp;
use lib qw( ../lib/ );
use SQL::Translator;
use FractalATE::DB;

my $db = FractalATE::DB->connect('dbi:sqlite:../data/fractalate.db');
$db->create_ddl_dir(['SQLite', 'MySQL'],
                       '0.001',
                       '../data/'
                       );
