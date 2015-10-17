package JSON::Schema::Generator::Handler::Array;

use strict;
use warnings;

sub process {
  my ($class, $array_type, $examples, $dispatch) = @_;
  return +{
    type  => $array_type->name,
    items => $dispatch->($array_type->element_type, $examples->[0]),
  };
}

1;
