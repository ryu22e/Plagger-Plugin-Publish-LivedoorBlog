use inc::Module::Install;

name     'Plagger-Plugin-Publish-LivedoorBlog';
all_from 'lib/Plagger/Plugin/Publish/LivedoorBlog.pm';
author   q{ryu22e <ryu22e@gmail.com>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

