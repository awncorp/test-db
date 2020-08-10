# NAME

Test::DB - Temporary Testing Databases

# ABSTRACT

Temporary Databases for Testing

# SYNOPSIS

    use Test::DB;

    my $tdb = Test::DB->new;

    # my $tdbo = $tdb->create(database => 'sqlite');

    # my $dbh = $tdbo->dbh;

# DESCRIPTION

This package provides a framework for setting up and tearing down temporary
databases for testing purposes. This framework requires a user (optionally with
password) which has the ability to create new databases and works by creating
test-specific databases owned by the user specified using the naming
convention: `(testing_db_{time}_{proc}_{rand})`.

# LIBRARIES

This package uses type constraints from:

[Types::Standard](https://metacpan.org/pod/Types%3A%3AStandard)

# METHODS

This package implements the following methods:

## create

    create(Str :$database, Str %options) : Maybe[InstanceOf["Test::DB::Object"]]

The create method generates a database based on the type specified and returns
a `Test::DB::Object` with an active connection, `dbh` and `dsn`. If the
database specified doesn't have a corresponding database drive this method will
returned the undefined value. The type of database can be omitted if the
`TESTDB_DATABASE` environment variable is set, if not the type of database
must be either `sqlite`, `mysql`, or `postgres`. Any options provided are
passed along to the test database object class constructor.

- create example #1

        # given: synopsis

        $tdb->create;

- create example #2

        # given: synopsis

        $ENV{TESTDB_DATABASE} = 'sqlite';

        $tdb->create;

- create example #3

        # given: synopsis

        $tdb->create(database => 'sqlite');

# AUTHOR

Al Newkirk, `awncorp@cpan.org`

# LICENSE

Copyright (C) 2011-2019, Al Newkirk, et al.

This is free software; you can redistribute it and/or modify it under the terms
of the The Apache License, Version 2.0, as elucidated in the ["license
file"](https://github.com/iamalnewkirk/test-db/blob/master/LICENSE).

# PROJECT

[Wiki](https://github.com/iamalnewkirk/test-db/wiki)

[Project](https://github.com/iamalnewkirk/test-db)

[Initiatives](https://github.com/iamalnewkirk/test-db/projects)

[Milestones](https://github.com/iamalnewkirk/test-db/milestones)

[Contributing](https://github.com/iamalnewkirk/test-db/blob/master/CONTRIBUTE.md)

[Issues](https://github.com/iamalnewkirk/test-db/issues)
