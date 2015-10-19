requires 'perl', '5.008001';

requires 'JSON::TypeInference';
requires 'List::MoreUtils';

on 'test' => sub {
    requires 'Devel::Cover';
    requires 'Devel::Cover::Report::Coveralls';
    requires 'Test::More', '0.98';
};

feature 'demo' => sub {
  requires 'Getopt::Long';
  requires 'JSON::XS';
};
