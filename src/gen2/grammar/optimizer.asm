  call CHAR2QUAD
  end
-- Rule
CHAR2QUAD:
  opencapture 0
  quad 63686172
  call S
  opencapture 1
  call HEXBYTE
  closecapture 1 0
  call S
  quad 63686172
  call S
  opencapture 2
  call HEXBYTE
  closecapture 2 0
  call S
  quad 63686172
  call S
  opencapture 3
  call HEXBYTE
  closecapture 3 0
  call S
  quad 63686172
  call S
  opencapture 4
  call HEXBYTE
  closecapture 4 0
  closecapture 0 0
  replace 0 __REPL_JMP_OVER_120
  quad 71756164
  char 20
  var 1
  var 2
  var 3
  var 4
  endreplace
__REPL_JMP_OVER_120:
  ret
-- Rule
HEXBYTE:
  counter 0 2
__TERM_123:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __TERM_123
  ret
-- Rule
S:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __TERM_131
__TERM_130:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __TERM_130
__TERM_131:
  ret

  end 0
