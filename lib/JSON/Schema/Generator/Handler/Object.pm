package JSON::Schema::Generator::Handler::Object;

use strict;
use warnings;

use List::MoreUtils qw(uniq);

sub process {
  my ($class, $object_type, $examples, $dispatch) = @_;
  my $examples_by_prop = {}; # HashRef[Str, ArrayRef[Any]]
  for my $data (@$examples) {
    for my $key (keys %$data) {
      $examples_by_prop->{$key} //= [];
      push @{$examples_by_prop->{$key}}, $data->{$key};
    }
  }
  my $properties = $object_type->properties;
  return {
    type       => $object_type->name,
    properties => {
      map { ($_ => $dispatch->($properties->{$_}, $examples_by_prop->{$_})) } keys %$properties,
    },
  };
}

1;
