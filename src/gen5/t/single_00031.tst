-- Assembly:

call deritem
end 0

__RULE_deritem:
  char 30
  call reg_derlength
  intrpcapture ruint32 8388607
  call oid
  ret

__RULE_reg_derlength:
  catch __RIGHTHAND_0
  catch __TERM_2
  maskedchar 00 80
  backcommit __TERM_3
__TERM_2:
  fail
__TERM_3:
  opencapture 0
  any
  closecapture 0
  commit __LEFTHAND_1
__RIGHTHAND_0:
  catch __RIGHTHAND_20
  char 81
  opencapture 1
  any
  closecapture 1
  commit __LEFTHAND_21
__RIGHTHAND_20:
  catch __RIGHTHAND_40
  char 82
  opencapture 2
  any
  any
  closecapture 2
  commit __LEFTHAND_41
__RIGHTHAND_40:
  catch __RIGHTHAND_66
  char 83
  opencapture 3
  any
  any
  any
  closecapture 3
  commit __LEFTHAND_67
__RIGHTHAND_66:
  char 84
  opencapture 4
  any
  any
  any
  any
  closecapture 4
__LEFTHAND_67:
__LEFTHAND_41:
__LEFTHAND_21:
__LEFTHAND_1:
  ret

__RULE_oid:
  ret

-- Hexinput:

30 18 06 10 2B 06 01 04 01 81 E0 6B 02 02 06 01 06 03 01 01 40 04 C0 A8 50 01

-- Result:

OK
