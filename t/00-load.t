#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Exception;

my $pkg;
BEGIN {
    $pkg = 'Catmandu::Store::DBI';
    use_ok $pkg;
}
require_ok $pkg;

done_testing 2;