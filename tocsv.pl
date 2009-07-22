#!/usr/bin/env perl

use warnings;
use strict;
use YAML::Syck qw/LoadFile/;
my $d = LoadFile('all_data.yml');
my @years = sort {$a <=> $b} keys %$d;
my %sources;
foreach my $y (@years) {
    @sources{ keys %{ $d->{$y} } } = '';
}

my @sources = sort(keys %sources);

use Text::CSV_XS;
my $csv = Text::CSV_XS->new;
$csv->combine("Year", @sources);
print $csv->string,"\n";

foreach my $y (@years) {
    my %row = %{$d->{$y}};
    $csv->combine($y,@row{@sources});
    print $csv->string,"\n";
}
