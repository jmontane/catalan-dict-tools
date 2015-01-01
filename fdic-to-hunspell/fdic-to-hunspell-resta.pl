use strict;
use warnings;
use autodie;
use utf8;
use Switch;
require "../libs/Flexio.pm";

binmode( STDOUT, ":utf8" );


my $diccionariarrel = "../diccionari-arrel/";
my @files = glob($diccionariarrel."*-lt.txt");

my $outputfile = "resta-mots.dic";
open( my $ofh,  ">:encoding(UTF-8)", $outputfile );

foreach my $file (@files) {
    open( my $fh,  "<:encoding(UTF-8)", $file );
    LINE: while (my $line = <$fh>) {
	if ($line =~ /^(.+) (.+) (.+)$/) {
	    my $forma = $1;
	    if ($forma =~ /^['-].*/) { next LINE; }
	    my $lema = $2;
	    my $postag = $3;
	    my $apostrofacions="";
	    # apostrofa d'
	    if ($postag =~ /^(RG.*|NP.*|DD.*)$/) {
		if (Flexio::apostrofa_masculi($forma)) {
		    $apostrofacions.="_Y";
		}
	    }
	    $apostrofacions =~ s/^(.+)$/\/$1/;
	    print $ofh "$forma$apostrofacions\n";
	}
    }
    close ($fh);
}
close ($ofh);