#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Plagger::Plugin::Publish::LivedoorBlog' ) || print "Bail out!\n";
}

diag( "Testing Plagger::Plugin::Publish::LivedoorBlog $Plagger::Plugin::Publish::LivedoorBlog::VERSION, Perl $], $^X" );
