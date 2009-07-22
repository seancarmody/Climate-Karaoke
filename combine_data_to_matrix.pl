#!/usr/bin/env perl
use warnings;
use strict;
use YAML qw/DumpFile/;
open my $DF, "<", "list_of_data_files.txt";
my $data = {};
while (<$DF>) {
    chomp $_;
    my ($dir, $source) = $_ =~ /\.\/(.*)\/(.*?)\.txt/;
    open my $IN, "<", $_;
    while (my $d = <$IN>) {
        chomp $d;
        next if $d =~ /Year/;
        my ($yr, $stat) = $d =~ /\s?(.*?)\s+(.*)/;
        $data->{$yr}->{ $dir . "_" . $source} = $stat;
    }
}
DumpFile("all_data.yml", $data);
