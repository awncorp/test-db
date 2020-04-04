use 5.014;

use strict;
use warnings;
use routines;

use Test::Auto;
use Test::More;

=name

Test::DB

=cut

=abstract

Temporary Databases for Testing

=cut

=includes

method: create

=cut

=synopsis

  package main;

  use Test::DB;

  my $tdb = Test::DB->new;

=cut

=libraries

Types::Standard

=cut

=description

This package provides a framework for setting up and tearing down temporary
databases for testing purposes. This framework requires a user (optionally with
password) which has the ability to create new databases and works by creating
test-specific databases owned by the user specified using the naming convention
of C<test_db_${time}_${proc}_{rand}>.

=cut

=method create

The create method generates a database based on the type specified and returns
a C<Test::DB::Object> with an active connection, C<dbh> and C<dsn>. If the
database specified doesn't have a corresponding database drive this method will
returned the undefined value. The type of database can be omitted if the
C<TESTDB_DATABASE> environment variable is set, if not the type of database
must be either C<sqlite>, C<mysql>, or C<postgres>.

=signature create

create(Str :$database, Str %options) : Maybe[InstanceOf["Test::DB::Object"]]

=example-1 create

  # given: synopsis

  $tdb->create

=cut

package main;

SKIP: {
  if (!$ENV{TESTDB_DATABASE}) {
    skip 'Environment not configured for testing';
  }

  my $test = testauto(__FILE__);

  my $subs = $test->standard;

  $subs->synopsis(fun($tryable) {
    ok my $result = $tryable->result;

    $result
  });

  $subs->example(-1, 'create', 'method', fun($tryable) {
    ok my $result = $tryable->result;
    ok $result->isa('Test::DB::Object');

    my $database = $ENV{TESTDB_DATABASE};

    ok $result->isa('Test::DB::Mssql') if (lc($database) eq 'mssql');
    ok $result->isa('Test::DB::Mysql') if (lc($database) eq 'mysql');
    ok $result->isa('Test::DB::Postgres') if (lc($database) eq 'postgres');
    ok $result->isa('Test::DB::Sqlite') if (lc($database) eq 'sqlite');

    ok $result->destroy;

    $result
  });
}

ok 1 and done_testing;
