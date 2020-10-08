-- Grammar:

RULE <- { .* } => handle_capture;

function handle_capture
  ()
{
  print('You said ' + capture);
}

-- Input:

Hello World!

-- Result:

OK
