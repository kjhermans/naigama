-- Assembly:

  skip 12
  char 08
  char 00
  maskedchar 40 f0
  skip 11
  skip 4
  catch NET2
  char c0
  char a8
  char 01
  any
  end 0
NET2:
  char 0a
  char 9d
  char 36
  any
  end 1

-- Hexinput:

0eaa 2a40 9121 c08c 6030 8943 0800 4500
003c 85ad 0000 3f06 aef8 0ad0 fb52 0a9d
3657 20fb d301 34e6 c154 f922 73d7 a010
0a30 c373 0000 0101 0512 f922 85a3 f922
8a16 f922 784a f922 8130

-- Result:

OK
