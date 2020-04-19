  call CHAR2QUAD
  end
-- Rule
CHAR2QUAD:
  opencapture 0
  char 63
  char 68
  char 61
  char 72
  call S
  opencapture 1
  call HEXBYTE
  closecapture 1 0
  call S
  char 63
  char 68
  char 61
  char 72
  call S
  opencapture 2
  call HEXBYTE
  closecapture 2 0
  call S
  char 63
  char 68
  char 61
  char 72
  call S
  opencapture 3
  call HEXBYTE
  closecapture 3 0
  call S
  char 63
  char 68
  char 61
  char 72
  call S
  opencapture 4
  call HEXBYTE
  closecapture 4 0
  closecapture 0 0
  replace __LABEL_120 __LABEL_121
__LABEL_120:
  startreplace
  char 71
  char 75
  char 61
  char 64
  char 20
  var 1
  var 2
  var 3
  var 4
  endreplace
__LABEL_121:
  ret
-- Rule
HEXBYTE:
  counter 0 2
__LABEL_124:
  set 000000000000ff037e0000007e00000000000000000000000000000000000000
  condjump 0 __LABEL_124
  ret
-- Rule
S:
  set 002e000001000000000000000000000000000000000000000000000000000000
  catch __LABEL_132 -- 2
__LABEL_131:
  set 002e000001000000000000000000000000000000000000000000000000000000
  partialcommit __LABEL_131
__LABEL_132:
  ret

  end 0
