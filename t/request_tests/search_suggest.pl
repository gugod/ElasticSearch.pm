#!perl

use Test::More;
use strict;
use warnings;
our $es;
my $r;

# FACETS SEARCH

isa_ok $r = $es->search(
    suggest => {
        t1 => {
            text  => "f0o",
            term => {
                field => 'text'
            },
        }
    },
    query => { term => { text => 'foo' } }
    ),
    'HASH',
    "search with suggest";

is $r->{hits}{total}, 17, ' - total correct';
my $f;
isa_ok $f= $r->{suggest}{t1}, 'ARRAY', 'text suggestion';
isa_ok $f= $r->{suggest}{t1}[0], 'HASH', 'text suggestion info on the first token';
isa_ok $f= $r->{suggest}{t1}[0]{options}, 'ARRAY', 'The actual text suggestions on the first token';

1
