use 5.014;

use strict;
use warnings;
use routines;

use Test::Auto;
use Test::More;

=name

Test::DB::Mysql

=cut

=abstract

Temporary Mysql Database for Testing

=cut

=includes

method: create
method: destroy

=cut

=synopsis

  package main;

  use Test::DB::Mysql;

  my $tdbo = Test::DB::Mysql->new;

  # my $dbh = $tdbo->dbh;

=cut

=libraries

Types::Standard

=cut

=inherits

Test::DB::Object

=cut

=integrates

Data::Object::Role::Buildable
Data::Object::Role::Immutable
Data::Object::Role::Stashable

=cut

=attributes

dbh: ro, opt, Object
dsn: ro, opt, Str
database: ro, opt, Str
hostname: ro, opt, Str
hostport: ro, opt, Str
username: ro, opt, Str
password: ro, opt, Str

=cut

=description

This package provides methods for generating and destroying Mysql databases for
testing purposes. The attributes can be set using their respective environment
variables: C<TESTDB_DATABASE>, C<TESTDB_USERNAME>, C<TESTDB_PASSWORD>,
C<TESTDB_HOSTNAME>, and C<TESTDB_HOSTPORT>.

=cut

=method create

The create method creates a temporary database and returns the invocant.

=signature create

create() : Object

=example-1 create

  # given: synopsis

  $tdbo->create;

  # <Test::DB::Mysql>

=cut

=method destroy

The destroy method destroys (drops) the database and returns the invocant.

=signature destroy

destroy() : Object

=example-1 destroy

  # given: synopsis

  $tdbo->create;
  $tdbo->destroy;

  # <Test::DB::Mysql>

=cut

package main;

SKIP: {
  if (!$ENV{TESTDB_DATABASE} || lc($ENV{TESTDB_DATABASE}) ne 'mysql') {
    skip 'Environment not configured for Mysql testing';
  }

  my $test = testauto(__FILE__);

  my $subs = $test->standard;

  $subs->synopsis(fun($tryable) {
    ok my $result = $tryable->result;

    $result
  });

  $subs->example(-1, 'create', 'method', fun($tryable) {
    ok my $result = $tryable->result;
    ok $result->isa('Test::DB::Mysql');
    ok $result->dbh;
    like $result->dsn, qr/dbi:mysql:database=testing_db_\d+_\d+_\d+/;

    $result->destroy;
    $result
  });

  $subs->example(-1, 'destroy', 'method', fun($tryable) {
    ok my $result = $tryable->result;
    ok $result->isa('Test::DB::Mysql');

    $result
  });
}

ok 1 and done_testing;
