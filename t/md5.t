#!/usr/bin/perl -w

use strict;
use Test::More tests => 7;
use File::Spec::Functions qw(:ALL);

BEGIN { use_ok('Audio::FLAC::Header') };

#########################

{

	# Be sure to test both code paths.
	for my $constructor (qw(_new_PP _new_XS)) {

		my $flac = Audio::FLAC::Header->$constructor(catdir('data', 'md5.flac'));

		ok($flac, "constructor: $constructor");

		my $checkVendor = '';

		if ($constructor =~ /PP/) {
			$checkVendor = 'Audio::FLAC::Header';
		} else {
			$checkVendor = 'libFLAC';
		}

		my $info = $flac->info();

		ok($info, "info block");

		ok($flac->info('MD5CHECKSUM') eq '00428198e1ae27ad16754f75ff068752', "md5");
       }

}

__END__
