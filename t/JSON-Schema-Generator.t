use strict;
use warnings;
use Test::More;
use Types::Serialiser;

require_ok 'JSON::Schema::Generator';

my $generator = JSON::Schema::Generator->new;
$generator->learn({ id => 1, name => 'yuno', magic => 1, career => ['a', 'b'] });
$generator->learn({ id => 2, name => 'miyako', magic => 'a', career => ['a'] });
$generator->learn({ id => 3, name => 'sae', is_megane => Types::Serialiser::true, magic => 3, career => ['a', 'b', 'c'] });
my $schema = $generator->generate();

is_deeply $schema, {
  '$schema'   => 'http://json-schema.org/draft-04/schema#',
  title       => 'TODO',
  description => 'TODO',
  type        => 'object',
  properties  => {
    id => {
      type    => 'number',
      example => 1,
    },
    name => {
      type    => 'string',
      example => 'yuno',
    },
    is_megane => {
      type    => 'boolean',
      example => Types::Serialiser::true,
    },
    magic => {
      type    => ['number', 'string'],
      example => 1,
    },
    career => {
      type  => 'array',
      items => {
        type    => 'string',
        example => 'a',
      },
    },
  },
  required => [ sort 'id', 'name', 'magic', 'career' ],
};

done_testing;
