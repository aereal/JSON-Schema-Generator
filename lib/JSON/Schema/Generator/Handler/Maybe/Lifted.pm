package JSON::Schema::Generator::Handler::Maybe::Lifted;

use strict;
use warnings;

sub process {
  my($class, $maybe_type, $example_data, $dispatch) = @_;
  return +{
    %{ $dispatch->($maybe_type->type, $example_data) },
  };
}

1;
