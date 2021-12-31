{
  stackfull => {
    code => -17,
    explicit => 'Stack about to exceed its maximum size'
  },
  stackempty => {
    code => -18,
    explicit => 'Stack pop on empty stack'
  },
  stackcorrupt => {
    code => -19,
    explicit => 'Corruption detected on stack'
  },
  badopcode => {
    code => -20,
    explicit => 'Unknown opcode'
  },
  codeoverflow => {
    code => -21,
    explicit => 'Jump offset exceeds bytecode length'
  },
  actionfull => {
    code => -22,
    explicit => 'Action list about to exceed its maximum size'
  },
  actionlist => {
    code => -23,
    explicit => ''
  },
  variable => {
    code => -24,
    explicit => ''
  },
  labelmap => {
    code => -25,
    explicit => ''
  },
  regfull => {
    code => -26,
    explicit => 'Registry about to exceed its maximum size'
  },
  regnotfound => {
    code => -27,
    explicit => 'Registry entry not found'
  },
  bitfault => {
    code => -28,
    explicit => 'Bit fault detected'
  },
  trap => {
    code => -29,
    explicit => ''
  },
  endlessloop => {
    code => -30,
    explicit => 'Endless loop detected'
  },
  maxstack => {
    code => -31,
    explicit => ''
  },
  maxinstr => {
    code => -32,
    explicit => ''
  },
  operandtype => {
    code => -1024,
    explicit => ''
  },
  intoverflow => {
    code => -1025,
    explicit => ''
  },
  scalartype => {
    code => -1026,
    explicit => 'Unknown scalar type encountered',
  },
  engine => {
    code => -1027,
    explicit => 'General engine error',
  },
  intrpcapture => {
    code => -1028,
    explicit => 'Interpret capture error',
  },
};
