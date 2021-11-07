-- Grammar:

FOO <- ( ![a-z] .)* { [a-z]+ } => bar

function bar
  (capture)
{
  print('you said' + capture);
}

-- Input:

312750923059abc4239940

-- Result:
Ok
