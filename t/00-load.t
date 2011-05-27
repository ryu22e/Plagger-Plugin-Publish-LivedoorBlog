#!perl -T

use Test::More;

BEGIN {
    use_ok('Plagger::Plugin::Publish::LivedoorBlog');
    use_ok('Atompub::Client');
    use_ok('XML::Atom::Entry');
}

diag(
"Testing Plagger::Plugin::Publish::LivedoorBlog $Plagger::Plugin::Publish::LivedoorBlog::VERSION, Perl $], $^X"
);

done_testing(3);
