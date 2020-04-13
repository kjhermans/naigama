#!/usr/bin/lua

require "re"

function absorb_file (file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

grammar = absorb_file( arg[ 1 ] )

parser = re.compile(grammar)
c = parser:pcode(parser)
print(c);
