-- Grammar:

UTF8TEXT  <- UTF8CHAR*
UTF8CHAR  <- ASCII / DOUBLE / TRIPLE / QUADRUPLE
ASCII     <- [\000-\177]
DOUBLE    <- [\300-\337] [\200-\277]
TRIPLE    <- [\340-\357] [\200-\277] [\200-\277]
QUADRUPLE <- [\360-\367] [\200-\277] [\200-\277] [\200-\277]

-- Hexinput:

e285a0202d206f6e650ae285a1202d2074776f0a
e285a2202d2074687265650ae285a3202d20666f
75720ae285a4202d20666976650ae285a5202d20
7369780ae285a6202d20736576656e0ae285a720
2d2065696768740ae285a8202d206e696e650ae2
85a9202d2074656e

-- Result:

OK
