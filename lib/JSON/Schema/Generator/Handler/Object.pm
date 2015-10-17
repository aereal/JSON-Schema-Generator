package JSON::Schema::Generator::Handler::Object;

use strict;
use warnings;

sub process {
  my ($class, $object_type, $example_data, $dispatch) = @_;
  my $properties = $object_type->properties;
  return {
    type       => $object_type->name,
    properties => {
      map { ($_ => $dispatch->($properties->{$_}, $example_data->{$_})) } keys %$properties,
    },
  };
}

1;
