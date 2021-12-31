-- Grammar:

RULE <- { .* } => capture

function capture
  (str)
{
  print(str);
}

-- Input:

foo

-- Result:

OK
