-- Grammar:

JSON         <- %s* HASH %s*
HASH         <- '{' %s* OPTHASHELTS %s* '}'
OPTHASHELTS  <- HASHELTS / ...
HASHELTS     <- HASHELT %s* ',' %s* HASHELTS / HASHELT
HASHELT      <- STRING %s* ':' %s* VALUE
ARRAY        <- '[' %s* OPTARRAYELTS %s* ']'
OPTARRAYELTS <- ARRAYELTS / ...
ARRAYELTS    <- VALUE %s* ',' %s* ARRAYELTS / VALUE
VALUE        <- STRING / FLOAT / INT / BOOL / NULL / HASH / ARRAY
STRING       <- { '"' [^"]* '"' }
INT          <- { [0-9]+ }
FLOAT        <- { [0-9]* '.' [0-9]+ }
BOOL         <- { 'true' / 'false' }
NULL         <- { 'null' }

-- Input:

{"widget": {
    "debug": true,
    "window": {
        "title": "Sample Konfabulator Widget",
        "name": "main_window",
        "width": 500,
        "height": 500
    },
    "image": {
        "src": { "foo" : "bar", "bar" : 0.23 },
        "name": "sun1",
        "hOffset": 250.0,
        "vOffset": 250.5,
        "alignment": "center"
    },
    "text": {
        "data": [ "some", "sub", "array", 3, 5.7, false, null ],
        "size": 36,
        "style": null,
        "name": "text1",
        "hOffset": 250,
        "vOffset": 100,
        "alignment": "center",
        "onMouseUp": "sun1.opacity = (sun1.opacity / 100) * 90;"
    }
}}
