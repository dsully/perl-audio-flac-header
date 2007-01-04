use ExtUtils::MakeMaker;
use Config;

$LDDLFLAGS = '';
$LDDLFLAGS = '-all_load' if $^O eq 'darwin';
$LDDLFLAGS = '-L/usr/pkg/lib' if $^O eq 'netbsd';

if ($^O =~ /win32/i) {
        $LIBS = '-lFLAC_static';
	$CCFLAGS = '';
} else {
        $LIBS = '-lFLAC';
	$CCFLAGS = '-Wall';
}

WriteMakefile(
	'NAME'		=> 'Audio::FLAC::Header',
	'VERSION_FROM'	=> 'Header.pm',
	'LIBS'		=> [$LIBS],
	'DEFINE'	=> '-O',
	'CCFLAGS'	=> $CCFLAGS,
	'LDDLFLAGS'	=> "$Config{'lddlflags'} $LDDLFLAGS",
);
