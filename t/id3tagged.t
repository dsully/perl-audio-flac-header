#!/usr/bin/perl -w

use strict;
use Test::More tests => 9;

BEGIN { use_ok('Audio::FLAC::Header') };

#########################

{

	# Be sure to test both code paths.
	for my $constructor (qw(new_PP new_XS)) {

		my $flac = Audio::FLAC::Header->$constructor('data/id3tagged.flac');

		ok $flac;

		my $info = $flac->info();

		ok $info;

		my $tags = $flac->tags();

		ok $tags;

		ok($tags->{'TITLE'} =~ /Allegro Maestoso/);
	}
}

__END__
