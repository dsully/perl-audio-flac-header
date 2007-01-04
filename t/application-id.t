#!/usr/bin/perl -w

use strict;
use Test::More tests => 11;

BEGIN { use_ok('Audio::FLAC::Header') };

#########################

{

	# Be sure to test both code paths.
	for my $constructor (qw(new_PP new_XS)) {

		my $flac = Audio::FLAC::Header->$constructor('data/appId.flac');

		ok $flac;

		my $info = $flac->info();

		ok $info;

		my $cue = $flac->cuesheet();

		ok $cue;

		my $app = $flac->application(1835361648);

		ok $app;

		ok($app =~ /musicbrainz/);
	}
}

__END__
