#!/usr/bin/env perl
use warnings;
use strict;

my $file = "fig613ipcc2007-unsmoothed.txt";
open my $FH, "<", $file or die "unable to open file";
my @series;
{
    local $/ = "\nSeries: ";
    @series = <$FH>;
}

foreach (@series) {
    next if $_ =~ /^-+/ms;
    my @data = split /\n/;
    $data[0] =~ s/^Series: //;
    my $out = $data[0] . ".txt";
    my ($dir) = $data[1] =~ /Units:\s+(.*?)\s+\(/;
    mkdir $dir if ! -e $dir;
    open my $FO, ">", "$dir/$out";
    print $FO join "\n", @data[3 .. ($#data -1)];
    close $FO;
    
}
