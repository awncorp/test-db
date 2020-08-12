package Test::DB;

use 5.014;

use strict;
use warnings;

use registry;
use routines;

use Data::Object::Class;

# VERSION

# METHODS

method build(Str :$database = $ENV{TESTDB_DATABASE}, Str %options) {
  delete $options{database};

  if (lc($database) eq 'mssql') {
    require Test::DB::Mssql;

    my $generator = Test::DB::Mssql->new(%options);

    return $generator;
  }
  elsif (lc($database) eq 'mysql') {
    require Test::DB::Mysql;

    my $generator = Test::DB::Mysql->new(%options);

    return $generator;
  }
  elsif (lc($database) eq 'postgres') {
    require Test::DB::Postgres;

    my $generator = Test::DB::Postgres->new(%options);

    return $generator;
  }
  elsif (lc($database) eq 'sqlite') {
    require Test::DB::Sqlite;

    my $generator = Test::DB::Sqlite->new(%options);

    return $generator;
  }
  else {

    return undef;
  }
}

method create(Str :$database = $ENV{TESTDB_DATABASE}, Str %options) {
  my $generator = $self->build(%options);

  if ($generator) {

    return $generator->create;
  }
  else {

    return undef;
  }
}

method clone(Str :$database = $ENV{TESTDB_DATABASE}, Str %options) {
  my $generator = $self->build(%options);

  if ($generator) {

    return $generator->clone;
  }
  else {

    return undef;
  }
}

1;
