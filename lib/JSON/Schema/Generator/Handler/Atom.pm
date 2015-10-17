package JSON::Schema::Generator::Handler::Atom;

use strict;
use warnings;

sub process {
  my ($class, $atom_type, $example_data, $dispatch) = @_;
  return +{
    type => $atom_type->name,
    ($atom_type->isa('JSON::TypeInference::Type::Unknown') ? () : (example => $example_data)),
  };
}

1;
