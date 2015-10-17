use strict;
use warnings;
use Test::More;
use Types::Serialiser;

require_ok 'JSON::Schema::Generator';

my $generator = JSON::Schema::Generator->new;
$generator->learn({ id => 1, name => 'yuno' });
$generator->learn({ id => 2, name => 'miyako' });
$generator->learn({ id => 3, name => 'sae', is_megane => Types::Serialiser::true });
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
      example => undef,
    },
  },
};

done_testing;
