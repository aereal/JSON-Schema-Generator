[![Build Status](https://travis-ci.org/aereal/JSON-Schema-Generator.svg?branch=master)](https://travis-ci.org/aereal/JSON-Schema-Generator) [![Coverage Status](https://img.shields.io/coveralls/aereal/JSON-Schema-Generator/master.svg?style=flat)](https://coveralls.io/r/aereal/JSON-Schema-Generator?branch=master)
# NAME

JSON::Schema::Generator - Generate JSON schema from data

# SYNOPSIS

    use JSON::Schema::Generator;
    my $generator = JSON::Schema::Generator->new;
    $generator->learn({ id => 1, name => 'yuno'  });
    $generator->learn({ id => 2, name => 'miyako' });
    $generator->learn({ id => 3, name => 'sae'  });
    my $schema = $generator->generate;

# DESCRIPTION

JSON::Schema::Generator generate a JSON schema from actual data.

It supports:

    * type inference (using L<JSON::TypeInference>)
    * embedding example values

# LICENSE

Copyright (C) aereal.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

aereal &lt;aereal@aereal.org>
