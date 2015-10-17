package JSON::Schema::Generator::Handler::Union;

use strict;
use warnings;

sub process {
  my ($class, $union_type, $example_data, $dispatch) = @_;
  return +{
    type    => [ map { $_->name } @{$union_type->types} ],
    example => $example_data,
  };
}

1;
