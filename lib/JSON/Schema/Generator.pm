package JSON::Schema::Generator;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use JSON::Schema::Generator::Handler::Array;
use JSON::Schema::Generator::Handler::Atom;
use JSON::Schema::Generator::Handler::Maybe::Lifted;
use JSON::Schema::Generator::Handler::Object;
use JSON::Schema::Generator::Handler::Union;
use JSON::TypeInference;

sub new {
  my ($class) = @_;
  return bless { learned_data => [] }, $class;
}

sub learn {
  my ($self, $data) = @_;
  push @{$self->{learned_data}}, $data;
}

sub generate {
  my ($self) = @_;
  my $inferred_type = JSON::TypeInference->infer($self->{learned_data});
  return {
    '$schema'   => 'http://json-schema.org/draft-04/schema#',
    title       => 'TODO',
    description => 'TODO',
    %{_dispatch($inferred_type, $self->{learned_data})},
  };
}

sub _dispatch {
  my ($type, $examples) = @_;
  my $dispatch = \&_dispatch;
  if ($type->name eq 'array') {
    return JSON::Schema::Generator::Handler::Array->process($type, $examples, $dispatch);
  } elsif ($type->name eq 'object') {
    return JSON::Schema::Generator::Handler::Object->process($type, $examples, $dispatch);
  } elsif ($type->name eq 'union') {
    return JSON::Schema::Generator::Handler::Union->process($type, $examples, $dispatch);
  } elsif ($type->name eq 'maybe') {
    return JSON::Schema::Generator::Handler::Maybe::Lifted->process($type, $examples, $dispatch);
  } else {
    return JSON::Schema::Generator::Handler::Atom->process($type, $examples, $dispatch);
  }
}

1;
__END__

=encoding utf-8

=head1 NAME

JSON::Schema::Generator - Generate JSON schema from data

=head1 SYNOPSIS

    use JSON::Schema::Generator;
    my $generator = JSON::Schema::Generator->new;
    $generator->learn({ id => 1, name => 'yuno'  });
    $generator->learn({ id => 2, name => 'miyako' });
    $generator->learn({ id => 3, name => 'sae'  });
    my $schema = $generator->generate;

=head1 DESCRIPTION

JSON::Schema::Generator generate a JSON schema from actual data.

It supports:

  * type inference (using L<JSON::TypeInference>)
  * embedding example values

=head1 LICENSE

Copyright (C) aereal.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

aereal E<lt>aereal@aereal.orgE<gt>

=cut

