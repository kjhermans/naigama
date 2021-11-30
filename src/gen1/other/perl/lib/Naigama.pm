package Naigama;

use Naigama::Engine;

sub new
{
  my $class = shift;
  my $grammar = shift;
  my $self = { };
  if (defined($grammar)) {
    $self->{grammar} = $grammar;
    $self->{assembly} = compile($grammar)
      || die "Compiler error: $@";
    $self->{bytecode} = assemble($self->{assembly})
      || die "Assembler error: $@";
  }
  bless $self, "$class";
  return $self;
}

sub compile
{
  my $grammar = shift;
  my $assembly;
  eval {
    require 'Naigama/naic';
    $assembly = do_compile($grammar);
  };
  return $assembly;
}

sub assemble
{
  my $assembly = shift;
  my $bytecode;
  eval {
    require 'Naigama/naia';
    $bytecode = do_assemble($assembly);
  };
  return $bytecode;
}

sub run
{
  my $self = shift;
  my $input = shift;
  my $engine = Naigama::Engine->new($self->{bytecode});
  my $output = $engine->run($input);
  return $output;
}

1;
