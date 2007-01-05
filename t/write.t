#!/usr/bin/perl -w

use strict;
use Test::More tests => 7;

use File::Spec::Functions qw(:ALL);
use File::Copy;

BEGIN { use_ok('Audio::FLAC::Header') };

#########################

{
	# Be sure to test both code paths.
	for my $constructor (qw(_new_PP _new_XS)) {

		my $empty = catdir('data', 'empty.flac');
		my $write = catdir('data', 'write.flac');

		copy($empty, $write);

		my $flac = Audio::FLAC::Header->$constructor($write);

		ok($flac, "constructor: $constructor");

		my $tags = $flac->tags;

		$tags->{'ALBUM'} = 'FOO';

		ok($flac->write, "Wrote out tags");

		undef $flac;

		my $read = Audio::FLAC::Header->$constructor($write);

		ok($read->tags('ALBUM') eq 'FOO', "Got written out tags");

		unlink($write);
	}
}

__END__
