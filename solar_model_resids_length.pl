#!/usr/bin/env perl
use warnings;
use strict;
use Text::CSV_XS;
my $csv = Text::CSV_XS->new;
my $old_sign=0;
while (<>) {
    next if $. == 1;
    chomp;
    $csv->parse($_);
    my @row = $csv->fields;
    $DB::single=1;
    my $sign= $row[2];
    print $. + 900 .",". $sign .  "\n" if $sign != $old_sign;
    $old_sign=$sign;
}
