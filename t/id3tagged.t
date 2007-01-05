#!/usr/bin/perl -w

use strict;
use Test::More tests => 9;
use File::Spec::Functions qw(:ALL);

BEGIN { use_ok('Audio::FLAC::Header') };

#########################

{

	# Be sure to test both code paths.
	for my $constructor (qw(_new_PP _new_XS)) {

		my $flac = Audio::FLAC::Header->$constructor(catdir('data', 'id3tagged.flac'));

		ok($flac, "constructor: $constructor");

		my $info = $flac->info();

		ok($info, "info block");

		my $tags = $flac->tags();

		ok($tags, "tags read");

		ok($tags->{'TITLE'} =~ /Allegro Maestoso/, "found title");
	}
}

__END__
