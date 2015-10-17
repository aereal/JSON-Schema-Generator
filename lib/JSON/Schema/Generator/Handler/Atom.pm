package JSON::Schema::Generator::Handler::Atom;

use strict;
use warnings;

sub process {
  my ($class, $atom_type, $examples, $dispatch) = @_;
  return +{
    type => $atom_type->name,
    ($atom_type->isa('JSON::TypeInference::Type::Unknown') ? () : (example => $examples->[0])),
  };
}

1;
