package JSON::Schema::Generator::Handler::Maybe::Lifted;

use strict;
use warnings;

sub process {
  my($class, $maybe_type, $examples, $dispatch) = @_;
  my $entity_examples = [ grep { $maybe_type->type->accepts($_) } @$examples ];
  return +{
    %{ $dispatch->($maybe_type->type, $entity_examples) },
  };
}

1;
