  call INSTRUCTIONS
  end 0

INSTRUCTIONS:
  catch __L2
__L3:
  call INSTR
  partialcommit __L3
__L2:
  catch __L4
  any
  failtwice
__L4:
  ret

INSTR:
  catch __L7
  call INSTR_ANY
  commit __L6
__L7:
  catch __L8
  call INSTR_BACKCOMMIT
  commit __L6
__L8:
  catch __L9
  call INSTR_CALL
  commit __L6
__L9:
  catch __L10
  call INSTR_CATCH
  commit __L6
__L10:
  catch __L11
  call INSTR_CHAR
  commit __L6
__L11:
  catch __L12
  call INSTR_CLOSECAPTURE
  commit __L6
__L12:
  catch __L13
  call INSTR_COMMIT
  commit __L6
__L13:
  catch __L14
  call INSTR_CONDJUMP
  commit __L6
__L14:
  catch __L15
  call INSTR_COUNTER
  commit __L6
__L15:
  catch __L16
  call INSTR_END
  commit __L6
__L16:
  catch __L17
  call INSTR_ENDISOLATE
  commit __L6
__L17:
  catch __L18
  call INSTR_ENDREPLACE
  commit __L6
__L18:
  catch __L19
  call INSTR_FAIL
  commit __L6
__L19:
  catch __L20
  call INSTR_FAILTWICE
  commit __L6
__L20:
  catch __L21
  call INSTR_INTRPCAPTURE
  commit __L6
__L21:
  catch __L22
  call INSTR_ISOLATE
  commit __L6
__L22:
  catch __L23
  call INSTR_JUMP
  commit __L6
__L23:
  catch __L24
  call INSTR_MASKEDCHAR
  commit __L6
__L24:
  catch __L25
  call INSTR_NOOP
  commit __L6
__L25:
  catch __L26
  call INSTR_OPENCAPTURE
  commit __L6
__L26:
  catch __L27
  call INSTR_PARTIALCOMMIT
  commit __L6
__L27:
  catch __L28
  call INSTR_QUAD
  commit __L6
__L28:
  catch __L29
  call INSTR_RANGE
  commit __L6
__L29:
  catch __L30
  call INSTR_REPLACE
  commit __L6
__L30:
  catch __L31
  call INSTR_RET
  commit __L6
__L31:
  catch __L32
  call INSTR_SET
  commit __L6
__L32:
  catch __L33
  call INSTR_SKIP
  commit __L6
__L33:
  catch __L34
  call INSTR_SPAN
  commit __L6
__L34:
  catch __L35
  call INSTR_TESTANY
  commit __L6
__L35:
  catch __L36
  call INSTR_TESTCHAR
  commit __L6
__L36:
  catch __L37
  call INSTR_TESTQUAD
  commit __L6
__L37:
  catch __L38
  call INSTR_TESTSET
  commit __L6
__L38:
  catch __L39
  call INSTR_TRAP
  commit __L6
__L39:
  call INSTR_VAR
__L6:
  ret

INSTR_ANY:
  opencapture 0
  any
  char 00
  char 03
  char e4
  closecapture 0
  ret

INSTR_BACKCOMMIT:
  opencapture 1
  any
  char 04
  char 03
  char c0
  any
  any
  any
  any
  closecapture 1
  ret

INSTR_CALL:
  opencapture 2
  any
  char 04
  char 03
  char 82
  any
  any
  any
  any
  closecapture 2
  ret

INSTR_CATCH:
  opencapture 3
  any
  char 04
  char 03
  char 93
  any
  any
  any
  any
  closecapture 3
  ret

INSTR_CHAR:
  opencapture 4
  any
  char 04
  char 03
  char d7
  any
  any
  any
  any
  closecapture 4
  ret

INSTR_CLOSECAPTURE:
  opencapture 5
  any
  char 04
  char 03
  char 00
  any
  any
  any
  any
  closecapture 5
  ret

INSTR_COMMIT:
  opencapture 6
  any
  char 04
  char 03
  char 36
  any
  any
  any
  any
  closecapture 6
  ret

INSTR_CONDJUMP:
  opencapture 7
  any
  char 08
  char 03
  char 21
  any
  any
  any
  any
  any
  any
  any
  any
  closecapture 7
  ret

INSTR_COUNTER:
  opencapture 8
  any
  char 08
  char 03
  char 56
  any
  any
  any
  any
  any
  any
  any
  any
  closecapture 8
  ret

INSTR_END:
  opencapture 9
  any
  char 04
  char 00
  char d8
  any
  any
  any
  any
  closecapture 9
  ret

INSTR_ENDISOLATE:
  opencapture 10
  any
  char 00
  char 30
  char 05
  closecapture 10
  ret

INSTR_ENDREPLACE:
  opencapture 11
  any
  char 00
  char 03
  char 99
  closecapture 11
  ret

INSTR_FAIL:
  opencapture 12
  any
  char 00
  char 03
  char 4b
  closecapture 12
  ret

INSTR_FAILTWICE:
  opencapture 13
  any
  char 00
  char 03
  char 90
  closecapture 13
  ret

INSTR_INTRPCAPTURE:
  opencapture 14
  any
  char 08
  char 00
  char 0f
  any
  any
  any
  any
  any
  any
  any
  any
  closecapture 14
  ret

INSTR_ISOLATE:
  opencapture 15
  any
  char 04
  char 30
  char 03
  any
  any
  any
  any
  closecapture 15
  ret

INSTR_JUMP:
  opencapture 16
  any
  char 04
  char 03
  char 33
  any
  any
  any
  any
  closecapture 16
  ret

INSTR_MASKEDCHAR:
  opencapture 17
  any
  char 08
  char 03
  char 65
  any
  any
  any
  any
  any
  any
  any
  any
  closecapture 17
  ret

INSTR_NOOP:
  opencapture 18
  any
  char 00
  char 00
  char 00
  closecapture 18
  ret

INSTR_OPENCAPTURE:
  opencapture 19
  any
  char 04
  char 03
  char 9c
  any
  any
  any
  any
  closecapture 19
  ret

INSTR_PARTIALCOMMIT:
  opencapture 20
  any
  char 04
  char 03
  char b4
  any
  any
  any
  any
  closecapture 20
  ret

INSTR_QUAD:
  opencapture 21
  any
  char 04
  char 03
  char 7e
  any
  any
  any
  any
  closecapture 21
  ret

INSTR_RANGE:
  opencapture 22
  any
  char 08
  char 03
  char bd
  any
  any
  any
  any
  any
  any
  any
  any
  closecapture 22
  ret

INSTR_REPLACE:
  opencapture 23
  any
  char 08
  char 03
  char 48
  any
  any
  any
  any
  any
  any
  any
  any
  closecapture 23
  ret

INSTR_RET:
  opencapture 24
  any
  char 00
  char 03
  char a0
  closecapture 24
  ret

INSTR_SET:
  opencapture 25
  any
  char 20
  char 03
  char ca
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  closecapture 25
  ret

INSTR_SKIP:
  opencapture 26
  any
  char 04
  char 03
  char 30
  any
  any
  any
  any
  closecapture 26
  ret

INSTR_SPAN:
  opencapture 27
  any
  char 20
  char 03
  char e1
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  closecapture 27
  ret

INSTR_TESTANY:
  opencapture 28
  any
  char 04
  char 03
  char 06
  any
  any
  any
  any
  closecapture 28
  ret

INSTR_TESTCHAR:
  opencapture 29
  any
  char 08
  char 03
  char 9a
  any
  any
  any
  any
  any
  any
  any
  any
  closecapture 29
  ret

INSTR_TESTQUAD:
  opencapture 30
  any
  char 08
  char 03
  char db
  any
  any
  any
  any
  any
  any
  any
  any
  closecapture 30
  ret

INSTR_TESTSET:
  opencapture 31
  any
  char 24
  char 03
  char 63
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  any
  closecapture 31
  ret

INSTR_TRAP:
  opencapture 32
  any
  char 00
  char ff
  char ff
  closecapture 32
  ret

INSTR_VAR:
  opencapture 33
  any
  char 04
  char 03
  char ee
  any
  any
  any
  any
  closecapture 33
  ret

