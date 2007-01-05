#!/usr/bin/perl -w

use strict;
use Test::More tests => 11;
use File::Spec::Functions qw(:ALL);

BEGIN { use_ok('Audio::FLAC::Header') };

#########################

{

	# Be sure to test both code paths.
	for my $constructor (qw(_new_PP _new_XS)) {

		my $flac = Audio::FLAC::Header->$constructor(catdir('data', 'appId.flac'));

		ok($flac, "constructor: $constructor");

		my $info = $flac->info();

		ok($info, "info exists");

		my $cue = $flac->cuesheet();

		ok($cue, "cue sheet exists");

		my $app = $flac->application(1835361648);

		ok($app, "application block exists");

		ok($app =~ /musicbrainz/, "found musicbrainz block");
	}
}

__END__
