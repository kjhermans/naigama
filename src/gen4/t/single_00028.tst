-- Grammar:

var a = 4;
  
function main
  ()
{
  return foo(1);
}

function foo
  (bar)
{
  var b=3;
  if (bar == 10) {
    return foobar(bar);
  } else {
    return foo(bar + b);
  }
}

function foobar
  (val)
{
  while (val < 30) {
    val = val + 10;
  }
  return val + a;
}

-- Input:

-- Result:
Ok
