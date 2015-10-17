package JSON::Schema::Generator::Handler::Union;

use strict;
use warnings;

sub process {
  my ($class, $union_type, $examples, $dispatch) = @_;
  return +{
    type    => [ map { $_->name } @{$union_type->types} ],
    example => $examples->[0],
  };
}

1;
