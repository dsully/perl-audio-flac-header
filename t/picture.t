#!/usr/bin/perl -w

use strict;
use Test::More tests => 7;
use File::Spec::Functions qw(:ALL);

BEGIN { use_ok('Audio::FLAC::Header') };

#########################

{
	# Be sure to test both code paths.
	for my $constructor (qw(_new_PP _new_XS)) {

		my $flac = Audio::FLAC::Header->$constructor(catdir('data', 'picture.flac'));

		my $vendor      = $flac->vendor_string;
		my $has_picture = 1;
	
		if ($vendor =~ /libFLAC\s+(\d+\.\d+\.\d+)/) {

			if ($1 lt '1.1.3') {
				$has_picture = 0;
			}
		}

		SKIP: {
			skip "XS - No PICTURE support", 3 unless $has_picture;

			ok($flac, "constructor: $constructor");

			my $picture = $flac->picture();

			ok($picture, "found picture");

			ok($picture->{'mimeType'} eq 'image/jpeg', "found jpeg");
		}
	}
}

__END__
