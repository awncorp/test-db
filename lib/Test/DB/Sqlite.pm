package Test::DB::Sqlite;

use 5.014;

use strict;
use warnings;

use registry;
use routines;

use Data::Object::Class;
use Data::Object::ClassHas;

extends 'Test::DB::Object';

with 'Data::Object::Role::Buildable';
with 'Data::Object::Role::Immutable';
with 'Data::Object::Role::Stashable';

use DBI;
use File::Spec ();
use File::Temp ();

# VERSION

# ATTRIBUTES

has 'dbh' => (
  is => 'ro',
  isa => 'Object',
  new => 1,
);

fun new_dbh($self) {
  DBI->connect($self->dsn, '', '', { RaiseError => 1, AutoCommit => 1 })
}

has 'dsn' => (
  is => 'ro',
  isa => 'Str',
  new => 1,
);

fun new_dsn($self) {
  "dbi:SQLite:dbname=@{[$self->file]}"
}

has 'file' => (
  is => 'ro',
  isa => 'Str',
  new => 1,
);

fun new_file($self) {
  File::Spec->catfile(File::Temp::tempdir, "@{[$self->database]}.db")
}

# METHODS

method create() {
  my $dbh = $self->dbh;

  $self->immutable;

  return $self;
}

method destroy() {
  my $file = $self->file;

  unlink $file;

  return $self;
}

1;
