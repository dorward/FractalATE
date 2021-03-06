#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;

name 'FractalATE';
all_from 'lib/FractalATE.pm';

requires 'Catalyst::Runtime' => '5.80007';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'Config::General';
requires 'Crypt::Skip32::Base32Crockford';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
