# $Id: Makefile.PL 10 1998-12-16 23:02:45Z daniel $

use inc::Module::Install;

name('Audio-FLAC-Header');
license('perl');
perl_version('5.005');
all_from('Header.pm');

if ($^O =~ /win32/i) {
	cc_lib_links('FLAC_static');
} else {
	cc_lib_links('FLAC');
	cc_optimize_flags('-Wall');
}

auto_install();
WriteAll();
