-- Assembly:

  char 30
  call derlength
  intrpcapture ruint32 default
  call oid
  call ipv4
  end 0

__RULE_oid:
  char 06
  call derlength
  intrpcapture ruint32 default
  call oidvalue
  ret

__RULE_oidvalue:
  opencapture 5
  opencapture 6
  any
  closecapture 6
  catch __TERM_22
__TERM_21:
  opencapture 7
  catch __TERM_28
__TERM_27:
  maskedchar 80 80
  partialcommit __TERM_27
__TERM_28:
  maskedchar 00 80
  closecapture 7
  partialcommit __TERM_21
__TERM_22:
  closecapture 5
  ret

__RULE_ipv4:
  char 40
  char 04
  opencapture 8
  any
  any
  any
  any
  closecapture 8
  ret

__RULE_derlength:
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

-- Hexinput:

30 18 06 10 2B 06 01 04 01 81 E0 6B 02 02 06 01 06 03 01 01 40 04 C0 A8 50 01

-- Result:

OK
