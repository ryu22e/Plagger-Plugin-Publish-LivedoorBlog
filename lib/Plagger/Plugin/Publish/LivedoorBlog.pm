package Plagger::Plugin::Publish::LivedoorBlog;

use 5.006;
use strict;
use warnings;

use base qw (Plagger::Plugin);

use Atompub::Client;
use XML::Atom::Entry;

sub register {
    my ( $self, $context ) = @_;
    $context->register_hook( $self, 'publish.feed' => \&feed, );
}

sub feed {
    my ( $self, $context, $args ) = @_;
    $context->error("URI is not defined.")
      if length( $self->{conf}->{uri} ) <= 0;
    my $body =
      $self->templatize( $self->{conf}->{template} || 'livedoorblog.tt',
        { feed => $args->{feed} } );
    eval {
        my $edit_uri = $self->post_to_blog(
            title => $args->{feed}->title,
            body  => $body,
        );

        $context->log( info => "Successfuly posted: $edit_uri" );
    };
    if ( my $err = $@ ) {
        $err = $err->[0] if ref $err && ref $err eq 'ARRAY';
        $context->error($err);
    }
}

sub post_to_blog {
    my $self    = shift;
    my %args    = @_;
    my $service = $self->{service};

    my $entry = XML::Atom::Entry->new;
    $entry->title( $self->conf->{title} || $args{title} || '' );
    $entry->content( $args{body} );

    my $category = XML::Atom::Category->new;
    $category->term( $self->conf->{category} );
    $entry->category($category);

    my $client = Atompub::Client->new;
    $client->username( $self->conf->{username} );
    $client->password( $self->conf->{password} );
    $service = $client->getService( $self->conf->{uri} );
    my $article_url = $service->workspace->collection->href;

    $client->createEntry( $article_url, $entry ) or die;
}

=head1 NAME

Plagger::Plugin::Publish::LivedoorBlog - The great new Plagger::Plugin::Publish::LivedoorBlog!

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

  - module: Publish::LivedoorBlog
    config:
      uri: http://livedoor.blogcms.jp/atom/
      username: Melody
      password: Nelson
      title: "Today's post from Plagger"
      category: "Example"

=head1 SUBROUTINES/METHODS

=head2 register

=head2 feed

=head2 post_to_blog

=head1 CONFIG

=head2 username

Your username on livedoor Blog.

=head2 password

Specify your password. Note that it's not your login password but API
password.

=head2 title

You can specifiy the title of new entry which will be defaults to
title of the feed.

=head2 category

Specifiy the category of new entry.

=cut

=head1 AUTHOR

ryu22e, C<< <ryu22e at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-plagger-plugin-publish-livedoorblog at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Plagger-Plugin-Publish-LivedoorBlog>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 ryu22e.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1;    # End of Plagger::Plugin::Publish::LivedoorBlog
