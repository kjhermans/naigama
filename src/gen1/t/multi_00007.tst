RULE <- !'a'				b		OK
RULE <- !'a'				a		NOK
RULE <- !'a' / 'b'			a		NOK
RULE <- !'a' / 'b'			b		OK
RULE <- !'a' / 'b'			c		OK

RULE <- ( &'a' 'a' ) 'b'		b		NOK
RULE <- ( &'a' 'a' ) 'b'		a		NOK
RULE <- ( &'a' 'a' ) 'b'		ab		OK

!'a'					b		OK
!'a'					a		NOK
!'a' / 'b'				a		NOK
!'a' / 'b'				b		OK
!'a' / 'b'				c		OK

( &'a' 'a' ) 'b'			b		NOK
( &'a' 'a' ) 'b'			a		NOK
( &'a' 'a' ) 'b'			ab		OK
