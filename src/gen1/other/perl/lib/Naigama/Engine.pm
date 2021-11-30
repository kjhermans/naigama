package Naigama::Engine;

sub new
{
  my $class = shift;
  my $bytecode = shift;
  my $self = {
    bytecode => $bytecode
  };
  bless $self, "$class";
  return $self;
}

sub run
{
  my $self = shift;
  my $input = shift;
  my $output = {};
  my $state = {
    input           => $input,
    stack           => [],
    pinpoints       => [],
    input_offset    => 0,
    bytecode_offset => 0,
    output          => $output,
  };
  ##.. loop
  return $output;
}

1;
