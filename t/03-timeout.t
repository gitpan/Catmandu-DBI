#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Exception;
use File::Temp qw(tempfile);

require Catmandu::Store::DBI;

my $driver_found = 1;
{
    local $@;
    eval {
        require DBD::SQLite;
    };
    if($@){
        $driver_found = 0;
    }
}


if(!$driver_found){

    plan skip_all => "database driver DBD::SQLite not found";

}else{

    my $timeout = 2;

    my($fh,$file);
    lives_ok(sub {
      ($fh,$file) = tempfile(UNLINK => 1,EXLOCK => 1);
    }, "database file created");

    my $bag;

    lives_ok(sub {

        $bag = Catmandu::Store::DBI->new(data_source => "dbi:SQLite:dbname=$file",timeout => $timeout,reconnect_after_timeout => 1)->bag()

    },"bag created");

    my @records;
    for(1..10){
      push @records,{ _id => "test-$_", test => $_ };
    }
    lives_ok(sub { $bag->add_many(\@records) },"bag add_many successfull");

    my $dbh1 = $bag->store->dbh;

    sleep $timeout + 2;

    my $dbh2 = $bag->store->dbh;

    isnt($dbh1,$dbh2,"database handle must change");

    @records = map { $_->{_id} = $_->{_id}.$_->{_id};$_ } @records;

    lives_ok(sub { $bag->add_many(\@records) },"bag add_many successfull");

    done_testing 5;

}
