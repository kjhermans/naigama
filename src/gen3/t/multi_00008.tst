[a-z]				a		OK
[a-z]				0		NOK
[0-9]				0		OK
[0-9]				a		NOK

[a-z][0-9]			a0		OK
[a-z][0-9]			a		NOK
[a-z][0-9]			,,		NOK
[a-z][0-9]			,		NOK
[0-9][a-z]			0a		OK
[0-9][a-z]			,,		NOK

[a-z0-9]			a		OK
[a-z0-9]			7		OK
[a-z0-9]			;		NOK

[a-z0-9;]			a		OK
[a-z0-9;]			9		OK
[a-z0-9;]			;		OK
[a-z0-9;]			!		NOK

[^0-9]				0		NOK
[^0-9]				a		OK

[a-z]^2				a		NOK
[a-z]^2				aa		OK
[a-z]^2				00		NOK
