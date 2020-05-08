-- Assembly:

START:
  catch UTF8_FOURBYTES
  maskedchar 00 80
  any
  commit NEXTCHAR

UTF8_FOURBYTES:
  catch UTF8_THREEBYTES
  maskedchar f0 f8 -- four bytes UTF-8
  any
  commit UTF8_FOURBYTES_REMAINDER
UTF8_FOURBYTES_REMAINDER:
  catch FAILME
  maskedchar 80 c0
  any
  maskedchar 80 c0
  any
  maskedchar 80 c0
  any
  commit NEXTCHAR

UTF8_THREEBYTES:
  catch UTF8_TWOBYTES
  maskedchar e0 f0 -- three bytes UTF-8
  any
  commit UTF8_THREEBYTES_REMAINDER
UTF8_THREEBYTES_REMAINDER:
  catch FAILME
  maskedchar 80 c0
  any
  maskedchar 80 c0
  any
  commit NEXTCHAR

UTF8_TWOBYTES:
  catch FAILME
  maskedchar c0 e0 -- two bytes UTF-8
  any
  maskedchar 80 c0
  any
  commit NEXTCHAR

NEXTCHAR:
  testany END
  jump START

END:
  end 0

FAILME:
  fail

-- Hexinput:

e20a85a0202d206f6e650ae285a1202d2074776f0a
e285a2202d2074687265650ae285a3202d20666f
75720ae285a4202d20666976650ae285a5202d20
7369780ae285a6202d20736576656e0ae285a720
2d2065696768740ae285a8202d206e696e650ae2
85a9202d2074656e

-- Result:

NOK
