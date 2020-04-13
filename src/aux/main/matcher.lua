#!/usr/bin/lua

require "re"

function absorb_file (file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

grammar = absorb_file( arg[ 1 ] )
text = absorb_file( arg[ 2 ] )

-- parser = re.compile(grammar)
success = re.match(text, grammar)

if (success) then
  print("Lua native succeeds.\n")
else
  print("Lua native fails.\n")
end
