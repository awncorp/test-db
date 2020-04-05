package Test::DB::Object;

use 5.014;

use strict;
use warnings;

use registry;
use routines;

use Data::Object::Class;
use Data::Object::ClassHas;

# VERSION

# ATTRIBUTES

has 'database' => (
  is => 'ro',
  isa => 'Str',
  new => 1,
);

fun new_database($self) {
  join '_', 'test_db', time, $$, sprintf "%04d", rand 999
}

# METHODS

method create() {

  die join ' ', ref($self), 'create not implemented';
}

method destroy() {

  die join ' ', ref($self), 'destroy not implemented';
}

1;
