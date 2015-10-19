#!/usr/bin/env perl

use strict;
use warnings;
use lib 'lib';

use Getopt::Long qw(:config posix_default no_ignore_case auto_help );
use JSON::Schema::Generator;
use JSON::XS;
use List::MoreUtils qw(uniq);
use Module::Load ();
use Scalar::Util qw(blessed);

GetOptions(
  \my %options,
  qw(
    repo=s
    config-package=s
    env=s@
  )
);

my $JSON = JSON::XS->new->canonical(1)->ascii(1)->indent(1)->pretty(1);

main(\%options);

sub main {
  my ($options) = @_;
  my $data = generate_data_from_config(
    repo           => $options->{repo},
    config_package => $options->{'config-package'},
  );
  my $schema = generate_schema_from_data($data, $options->{env});
  print $JSON->encode($schema);
}

sub generate_data_from_config {
  my (%args) = @_;
  my $repo       = $args{repo};
  my $config_pkg = $args{config_package};

  local @INC = (
    "$repo/lib", "$repo/local/lib/perl5",
    @INC
  );
  Module::Load::load($config_pkg);

  sub as_jsonable {
      my ($hash) = @_;
      return +{
          map { ($_ => _as_json_scalar($hash->{$_})) } keys %$hash
      };
  }

  sub _as_json_scalar {
      my ($scalar) = @_;
      return blessed($scalar) ? _blessed_as_json_scalar($scalar) : $scalar;
  }

  sub _blessed_as_json_scalar {
      my ($blessed) = @_;
      return $blessed.q(); # XXX stringify
  }

  my $data = $config_pkg->_data;
  my $environment_variable_name = $data->{name};
  my $env_keys = [ keys %{$data->{envs}} ];
  my $config_keys = [ uniq sort map { keys %{$data->{envs}->{$_}} } @$env_keys ];
  my $config = {
      map { local $ENV{$environment_variable_name} = $_; ($_ => as_jsonable($config_pkg->current)) } @$env_keys
  };
  return $config;
}

sub generate_schema_from_data {
  my ($data, $envs) = @_;

  my $generator = JSON::Schema::Generator->new;
  $generator->learn($data->{$_}) for (@$envs);
  my $schema = $generator->generate;

  return $schema;
}

__END__

=head1 SYNOPSIS

    $ generate-config-env-schema.pl --repo PATH_TO_REPO --config-package My::Config --env ENV [--env ENV, ...]

=cut

