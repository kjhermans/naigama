-- Grammar:

function __main
  ()
{
  foobar(3, 4, 5);
}

function foobar
  (num1, num2, num3)
{
  return num1 * num2 * num3;
}

-- Input:

foo

-- Result:

OK
