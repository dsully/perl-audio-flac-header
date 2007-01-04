#!/usr/bin/perl -w

use strict;
use Test::More tests => 31;

BEGIN { use_ok('Audio::FLAC::Header') };

#########################

{

	# Be sure to test both code paths.
	for my $constructor (qw(new_PP new_XS)) {

		my $flac = Audio::FLAC::Header->$constructor('data/test.flac');

		ok $flac;

		my $info = $flac->info();

		ok $info;

		ok($flac->info('SAMPLERATE') == 44100);
		ok($flac->info('MD5CHECKSUM') eq '592fb7897a3589c6acf957fd3f8dc854');
		ok($flac->info('TOTALSAMPLES') == 153200460);

		my $tags = $flac->tags();

		ok $tags;

		is($flac->tags('AUTHOR'), 'Praga Khan');

		# XXX - should have accessors
		ok($flac->{'trackLengthFrames'} =~ /70.00\d+/);
		ok($flac->{'trackLengthMinutes'} == 57);
		ok($flac->{'bitRate'} =~ /1.236\d+/);
		ok($flac->{'trackTotalLengthSeconds'} =~ /3473.93\d+/);

		my $cue = $flac->cuesheet();

		ok $cue;

		ok(scalar @{$cue} == 37);

		ok($cue->[35] =~ /REM FLAC__lead-in 88200/);
		ok($cue->[36] =~ /REM FLAC__lead-out 170 153200460/);
	}
}

__END__
