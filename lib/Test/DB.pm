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
  if (lc($database) eq 'mssql') {
    require Test::DB::Mssql; return Test::DB::Mssql->new(%options);
  }
  elsif (lc($database) eq 'mysql') {
    require Test::DB::Mysql; return Test::DB::Mysql->new(%options);
  }
  elsif (lc($database) eq 'postgres') {
    require Test::DB::Postgres; return Test::DB::Postgres->new(%options);
  }
  elsif (lc($database) eq 'sqlite') {
    require Test::DB::Sqlite; return Test::DB::Sqlite->new(%options);
  }
  else {
    return undef;
  }
}

method create(Str :$database = $ENV{TESTDB_DATABASE}, Str %options) {
  if (my $generator = $self->build(%options, database => $database)) {
    return $generator->create;
  }
  else {
    return undef;
  }
}

method clone(Str :$database = $ENV{TESTDB_DATABASE}, Str %options) {
  if (my $generator = $self->build(%options, database => $database)) {
    return $generator->clone;
  }
  else {
    return undef;
  }
}

1;
