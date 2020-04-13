## Instructions are binarily encoded as four-byters, where:
## Byte 0: zero
## Byte 1: instruction size
## Byte 2: instruction group
## Byte 3: instruction

## Instructions must be numbered 0x03, 0x05, 0x09, 0x0a, 0x0f, 0x33
## to ensure a Hamming distance of at least 2 between instructions,
## allowing dual upset events between instructions.

{
  noop => {
    instr => 0x00,
    size => 4,
    param1 => '-',
    param2 => '-',
    impl => '
      NOOP
    ',
  },

  call => {
    instr => ( 0x03 | ( 0x03 << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'address',
    param2 => '-',
    impl => '
      ADD REG1, codeptr, 40
      PUSH REG1
      PUSHLIT 1
      JUMP param1
    ',
  },
  ret => {
    instr => ( 0x05 | ( 0x03 << 8) | ( 0x00 << 16)),
    size => 4,
    param1 => '-',
    param2 => '-',
    impl => '
      POP REG1
      FAIL RAISE, fatal
      CMP REG1, 1
      POP REG1
      JUMP REG1
    ',
  },
  jump => {
    instr => ( 0x09 | ( 0x03 << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'address',
    param2 => '-',
    impl => '
      JUMP param1
    ',
  },
  end => {
    instr => ( 0x0a | ( 0x03 << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'code',
    param2 => '-',
    impl => '
      ASSIGN REG0, param1
      RAISE end
    ',
  },
  counter => {
    instr => ( 0x0f | ( 0x03 << 8) | ( 0x08 << 16)),
    size => 12,
    param1 => 'register',
    param2 => 'value',
  },
  condjump => {
    instr => ( 0x33 | ( 0x03 << 8) | ( 0x08 << 16)),
    size => 12,
    param1 => 'register',
    param2 => 'address',
  },

## Matching instructions

  any => {
    instr => ( 0x03 | ( 0x05 << 8) | ( 0x00 << 16)),
    size => 4,
    param1 => '-',
    param2 => '-',
    impl => '
      FAIL JUMP, <#fail>
      LT inputpos, inputlen
      INC inputpos, 1
    ',
  },
  testany => {
    instr => ( 0x05 | ( 0x05 << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'address',
    param2 => '-',
  },
  char => {
    instr => ( 0x09 | ( 0x05 << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'char',
    param2 => '-',
    impl => '
      FAIL JUMP, <#fail>
      LT inputpos, inputlen
      CMP inputchar, param1
      INC inputpos, 1
    ',
  },
  maskedchar => {
    instr => ( 0x0a | ( 0x05 << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'char',
    param2 => 'mask',
  },
  testchar => {
    instr => ( 0x0f | ( 0x05 << 8) | ( 0x08 << 16)),
    size => 12,
    param1 => 'address',
    param2 => 'char',
  },
  quad => {
    instr => ( 0x33 | ( 0x05 << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'quad',
    param2 => '-',
  },
  testquad => {
    instr => ( 0x35 | ( 0x05 << 8) | ( 0x08 << 16)),
    size => 12,
    param1 => 'address',
    param2 => 'quad',
  },
  set => {
    instr => ( 0x39 | ( 0x05 << 8) | ( 0x20 << 16)),
    size => 36,
    param1 => 'set',
    param2 => '-',
  },
  testset => {
    instr => ( 0x3a | ( 0x05 << 8) | ( 0x24 << 16)),
    size => 40,
    param1 => 'address',
    param2 => 'set',
  },
  span => {
    instr => ( 0x3f | ( 0x05 << 8) | ( 0x20 << 16)),
    size => 36,
    param1 => 'set',
    param2 => '-',
  },
  range => {
    instr => ( 0x53 | ( 0x05 << 8) | ( 0x08 << 16)),
    size => 12,
    param1 => 'number',
    param2 => 'number',
  },
  skip => {
    instr => ( 0x55 | ( 0x05 << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'number',
    param2 => '-',
    impl => '
      SUB REG1, inputlen, inputpos
      FAIL JUMP, <#fail>
      LT param1, REG1
      INC inputpos, param1
    ',
  },

## Experimental, actually part of the group above.
  skipvar => {
    instr => ( 0x53 | ( 0x09 << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'slot',
    param2 => '-',
    docshort => 'Skips number of bytes forward as stored in an
                 unsigned integer interpreted slot',
  },

  catch => {
    instr => ( 0x03 | ( 0x0a << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'address',
    param2 => '-',
    impl => '
      PUSH inputpos
      PUSH actionlen
      PUSH param1
      PUSH 3
    ',
  },
  commit => {
    instr => ( 0x05 | ( 0x0a << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'address',
    param2 => '-',
    impl => '
      POP REG1
      FAIL RAISE, fatal
      CMP REG1, 3
      POP
      POP
      POP
      JUMP param1
    ',
  },
  partialcommit => {
    instr => ( 0x09 | ( 0x0a << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'address',
    param2 => '-',
    impl => '
      FAIL RAISE, fatal
      POP REG1
      CMP REG1, 3
      POP REG1
      POP REG2
      POP REG3
      ASSIGN REG3, inputpos
      PUSH REG3
      PUSH REG2
      PUSH REG1
      PUSH 3
      JUMP param1
    ',
  },
  fail => {
    instr => ( 0x0a | ( 0x0a << 8) | ( 0x00 << 16)),
    size => 4,
    param1 => '-',
    param2 => '-',
    impl => '
      JUMP <#fail>
    ',
  },
  failtwice => {
    instr => ( 0x0f | ( 0x0a << 8) | ( 0x00 << 16)),
    size => 4,
    param1 => '-',
    param2 => '-',
    impl => '
      JUMP <#failtwice>
    ',
  },
  backcommit => {
    instr => ( 0x30 | ( 0x0a << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'address',
    param2 => '-',
    impl => '
      POP REG1
      FAIL RAISE, fatal
      CMP REG1, 3
      POP REG1
      POP REG2
      POP REG3
      ASSIGN actionlen, REG2
      ASSIGN inputpos, REG3
      JUMP param1
    ',
  },

## Capture instructions

  opencapture => {
    instr => ( 0x03 | ( 0x0f << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'slot',
    param2 => '-',
  },
  closecapture => {
    instr => ( 0x05 | ( 0x0f << 8) | ( 0x08 << 16)),
    size => 12,
    param1 => 'slot',
    param2 => 'type',
  },
  var => {
    instr => ( 0x09 | ( 0x0f << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'slot',
    param2 => '-',
  },
  replace => {
    instr => ( 0x0a | ( 0x0f << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'slot',
    param2 => '-',
  },
  replacestring => {
    instr => ( 0x0f | ( 0x0f << 8) | ( 0x04 << 16)),
    size => 8,
    param1 => 'length',
    param2 => 'string',
    doc => 'This is a semi instruction.'
  },
};
