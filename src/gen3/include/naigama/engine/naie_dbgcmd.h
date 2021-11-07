#ifndef _BYTECODE_DEBUGCOMMAND_H_
#define _BYTECODE_DEBUGCOMMAND_H_

#define _BYTECODE_DEBUGCOMMAND \
0x85, 0x04, 0x03, 0x82, 0x10, 0x00, 0x00, 0x10, \
0xdc, 0x04, 0x00, 0xd8, 0x00, 0x00, 0x00, 0x00, \
0x94, 0x04, 0x03, 0x93, 0x50, 0x00, 0x00, 0x50, \
0x9b, 0x04, 0x03, 0x9c, 0x00, 0x00, 0x00, 0x00, \
0x94, 0x04, 0x03, 0x93, 0x38, 0x00, 0x00, 0x38, \
0x79, 0x04, 0x03, 0x7e, 0x6e, 0x65, 0x78, 0x74, \
0x31, 0x04, 0x03, 0x36, 0x40, 0x00, 0x00, 0x40, \
0xd0, 0x04, 0x03, 0xd7, 0x6e, 0x00, 0x00, 0x6e, \
0x07, 0x04, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x31, 0x04, 0x03, 0x36, 0xd1, 0x00, 0x05, 0xd4, \
0x94, 0x04, 0x03, 0x93, 0x90, 0x00, 0x00, 0x90, \
0x9b, 0x04, 0x03, 0x9c, 0x01, 0x00, 0x00, 0x01, \
0x94, 0x04, 0x03, 0x93, 0x78, 0x00, 0x00, 0x78, \
0x79, 0x04, 0x03, 0x7e, 0x71, 0x75, 0x69, 0x74, \
0x31, 0x04, 0x03, 0x36, 0x80, 0x00, 0x00, 0x80, \
0xd0, 0x04, 0x03, 0xd7, 0x71, 0x00, 0x00, 0x71, \
0x07, 0x04, 0x03, 0x00, 0x01, 0x00, 0x00, 0x01, \
0x31, 0x04, 0x03, 0x36, 0xd1, 0x00, 0x05, 0xd4, \
0x94, 0x04, 0x03, 0x93, 0xd0, 0x00, 0x00, 0xd0, \
0x9b, 0x04, 0x03, 0x9c, 0x02, 0x00, 0x00, 0x02, \
0x94, 0x04, 0x03, 0x93, 0xb8, 0x00, 0x00, 0xb8, \
0x79, 0x04, 0x03, 0x7e, 0x63, 0x6f, 0x6e, 0x74, \
0x31, 0x04, 0x03, 0x36, 0xc0, 0x00, 0x00, 0xc0, \
0xd0, 0x04, 0x03, 0xd7, 0x63, 0x00, 0x00, 0x63, \
0x07, 0x04, 0x03, 0x00, 0x02, 0x00, 0x00, 0x02, \
0x31, 0x04, 0x03, 0x36, 0xd1, 0x00, 0x05, 0xd4, \
0x94, 0x04, 0x03, 0x93, 0x11, 0x00, 0x01, 0x10, \
0x9b, 0x04, 0x03, 0x9c, 0x03, 0x00, 0x00, 0x03, \
0x94, 0x04, 0x03, 0x93, 0xf8, 0x00, 0x00, 0xf8, \
0x79, 0x04, 0x03, 0x7e, 0x6f, 0x76, 0x65, 0x72, \
0x31, 0x04, 0x03, 0x36, 0x01, 0x00, 0x01, 0x00, \
0xd0, 0x04, 0x03, 0xd7, 0x6f, 0x00, 0x00, 0x6f, \
0x07, 0x04, 0x03, 0x00, 0x03, 0x00, 0x00, 0x03, \
0x31, 0x04, 0x03, 0x36, 0xd1, 0x00, 0x05, 0xd4, \
0x94, 0x04, 0x03, 0x93, 0x69, 0x00, 0x01, 0x68, \
0x9b, 0x04, 0x03, 0x9c, 0x04, 0x00, 0x00, 0x04, \
0x94, 0x04, 0x03, 0x93, 0x39, 0x00, 0x01, 0x38, \
0x79, 0x04, 0x03, 0x7e, 0x68, 0x65, 0x6c, 0x70, \
0x31, 0x04, 0x03, 0x36, 0x59, 0x00, 0x01, 0x58, \
0x94, 0x04, 0x03, 0x93, 0x51, 0x00, 0x01, 0x50, \
0xd0, 0x04, 0x03, 0xd7, 0x68, 0x00, 0x00, 0x68, \
0x31, 0x04, 0x03, 0x36, 0x59, 0x00, 0x01, 0x58, \
0xd0, 0x04, 0x03, 0xd7, 0x3f, 0x00, 0x00, 0x3f, \
0x07, 0x04, 0x03, 0x00, 0x04, 0x00, 0x00, 0x04, \
0x31, 0x04, 0x03, 0x36, 0xd1, 0x00, 0x05, 0xd4, \
0x94, 0x04, 0x03, 0x93, 0xc1, 0x00, 0x01, 0xc0, \
0x9b, 0x04, 0x03, 0x9c, 0x05, 0x00, 0x00, 0x05, \
0x94, 0x04, 0x03, 0x93, 0xa9, 0x00, 0x01, 0xa8, \
0x79, 0x04, 0x03, 0x7e, 0x76, 0x65, 0x72, 0x62, \
0xd0, 0x04, 0x03, 0xd7, 0x6f, 0x00, 0x00, 0x6f, \
0xd0, 0x04, 0x03, 0xd7, 0x73, 0x00, 0x00, 0x73, \
0xd0, 0x04, 0x03, 0xd7, 0x65, 0x00, 0x00, 0x65, \
0x31, 0x04, 0x03, 0x36, 0xb1, 0x00, 0x01, 0xb0, \
0xd0, 0x04, 0x03, 0xd7, 0x76, 0x00, 0x00, 0x76, \
0x07, 0x04, 0x03, 0x00, 0x05, 0x00, 0x00, 0x05, \
0x31, 0x04, 0x03, 0x36, 0xd1, 0x00, 0x05, 0xd4, \
0x94, 0x04, 0x03, 0x93, 0xf1, 0x00, 0x01, 0xf0, \
0x9b, 0x04, 0x03, 0x9c, 0x06, 0x00, 0x00, 0x06, \
0x79, 0x04, 0x03, 0x7e, 0x73, 0x74, 0x61, 0x74, \
0xd0, 0x04, 0x03, 0xd7, 0x65, 0x00, 0x00, 0x65, \
0x07, 0x04, 0x03, 0x00, 0x06, 0x00, 0x00, 0x06, \
0x31, 0x04, 0x03, 0x36, 0xd1, 0x00, 0x05, 0xd4, \
0x94, 0x04, 0x03, 0x93, 0xeb, 0x00, 0x03, 0xe8, \
0x9b, 0x04, 0x03, 0x9c, 0x07, 0x00, 0x00, 0x07, \
0x79, 0x04, 0x03, 0x7e, 0x69, 0x6e, 0x70, 0x75, \
0xd0, 0x04, 0x03, 0xd7, 0x74, 0x00, 0x00, 0x74, \
0xe9, 0x20, 0x03, 0xca, 0x00, 0x2e, 0x00, 0x00, \
0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x94, 0x04, 0x03, 0x93, \
0x6a, 0x00, 0x02, 0x68, 0xe9, 0x20, 0x03, 0xca, \
0x00, 0x2e, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0xb3, 0x04, 0x03, 0xb4, 0x3e, 0x00, 0x02, 0x3c, \
0x94, 0x04, 0x03, 0x93, 0x53, 0x00, 0x03, 0x50, \
0x79, 0x04, 0x03, 0x7e, 0x6f, 0x66, 0x66, 0x73, \
0xd0, 0x04, 0x03, 0xd7, 0x65, 0x00, 0x00, 0x65, \
0xd0, 0x04, 0x03, 0xd7, 0x74, 0x00, 0x00, 0x74, \
0xe9, 0x20, 0x03, 0xca, 0x00, 0x2e, 0x00, 0x00, \
0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x94, 0x04, 0x03, 0x93, \
0xe2, 0x00, 0x02, 0xe0, 0xe9, 0x20, 0x03, 0xca, \
0x00, 0x2e, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0xb3, 0x04, 0x03, 0xb4, 0xb6, 0x00, 0x02, 0xb4, \
0x9b, 0x04, 0x03, 0x9c, 0x08, 0x00, 0x00, 0x08, \
0xe9, 0x20, 0x03, 0xca, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0xff, 0x03, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x94, 0x04, 0x03, 0x93, \
0x43, 0x00, 0x03, 0x40, 0xe9, 0x20, 0x03, 0xca, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x03, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0xb3, 0x04, 0x03, 0xb4, 0x17, 0x00, 0x03, 0x14, \
0x07, 0x04, 0x03, 0x00, 0x08, 0x00, 0x00, 0x08, \
0x31, 0x04, 0x03, 0x36, 0xdb, 0x00, 0x03, 0xd8, \
0x79, 0x04, 0x03, 0x7e, 0x74, 0x65, 0x78, 0x74, \
0xe9, 0x20, 0x03, 0xca, 0x00, 0x2e, 0x00, 0x00, \
0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x94, 0x04, 0x03, 0x93, \
0xb3, 0x00, 0x03, 0xb0, 0xe9, 0x20, 0x03, 0xca, \
0x00, 0x2e, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0xb3, 0x04, 0x03, 0xb4, 0x87, 0x00, 0x03, 0x84, \
0x9b, 0x04, 0x03, 0x9c, 0x09, 0x00, 0x00, 0x09, \
0xe7, 0x00, 0x03, 0xe4, 0x94, 0x04, 0x03, 0x93, \
0xd3, 0x00, 0x03, 0xd0, 0xe7, 0x00, 0x03, 0xe4, \
0xb3, 0x04, 0x03, 0xb4, 0xc7, 0x00, 0x03, 0xc4, \
0x07, 0x04, 0x03, 0x00, 0x09, 0x00, 0x00, 0x09, \
0x07, 0x04, 0x03, 0x00, 0x07, 0x00, 0x00, 0x07, \
0x31, 0x04, 0x03, 0x36, 0xd1, 0x00, 0x05, 0xd4, \
0x94, 0x04, 0x03, 0x93, 0xd0, 0x00, 0x04, 0xd4, \
0x9b, 0x04, 0x03, 0x9c, 0x0a, 0x00, 0x00, 0x0a, \
0x79, 0x04, 0x03, 0x7e, 0x69, 0x6e, 0x73, 0x74, \
0xd0, 0x04, 0x03, 0xd7, 0x72, 0x00, 0x00, 0x72, \
0xe9, 0x20, 0x03, 0xca, 0x00, 0x2e, 0x00, 0x00, \
0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x94, 0x04, 0x03, 0x93, \
0x64, 0x00, 0x04, 0x60, 0xe9, 0x20, 0x03, 0xca, \
0x00, 0x2e, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0xb3, 0x04, 0x03, 0xb4, 0x30, 0x00, 0x04, 0x34, \
0x9b, 0x04, 0x03, 0x9c, 0x0b, 0x00, 0x00, 0x0b, \
0x94, 0x04, 0x03, 0x93, 0xb8, 0x00, 0x04, 0xbc, \
0x5d, 0x08, 0x03, 0x56, 0x00, 0x00, 0x00, 0x00, \
0x3f, 0x00, 0x00, 0x3f, 0xe9, 0x20, 0x03, 0xca, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0xfe, 0xff, 0xff, 0x07, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0xb3, 0x04, 0x03, 0xb4, 0xac, 0x00, 0x04, 0xa8, \
0x2a, 0x08, 0x03, 0x21, 0x00, 0x00, 0x00, 0x00, \
0x78, 0x00, 0x04, 0x7c, 0x31, 0x04, 0x03, 0x36, \
0xb8, 0x00, 0x04, 0xbc, 0x07, 0x04, 0x03, 0x00, \
0x0b, 0x00, 0x00, 0x0b, 0x07, 0x04, 0x03, 0x00, \
0x0a, 0x00, 0x00, 0x0a, 0x31, 0x04, 0x03, 0x36, \
0xd1, 0x00, 0x05, 0xd4, 0x9b, 0x04, 0x03, 0x9c, \
0x0c, 0x00, 0x00, 0x0c, 0x79, 0x04, 0x03, 0x7e, \
0x6c, 0x61, 0x62, 0x65, 0xd0, 0x04, 0x03, 0xd7, \
0x6c, 0x00, 0x00, 0x6c, 0xe9, 0x20, 0x03, 0xca, \
0x00, 0x2e, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x94, 0x04, 0x03, 0x93, 0x41, 0x00, 0x05, 0x44, \
0xe9, 0x20, 0x03, 0xca, 0x00, 0x2e, 0x00, 0x00, \
0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0xb3, 0x04, 0x03, 0xb4, \
0x1d, 0x00, 0x05, 0x18, 0x9b, 0x04, 0x03, 0x9c, \
0x0d, 0x00, 0x00, 0x0d, 0xe9, 0x20, 0x03, 0xca, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0xfe, 0xff, 0xff, 0x87, 0xfe, 0xff, 0xff, 0x07, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x94, 0x04, 0x03, 0x93, 0xc1, 0x00, 0x05, 0xc4, \
0x5d, 0x08, 0x03, 0x56, 0x00, 0x00, 0x00, 0x00, \
0x3f, 0x00, 0x00, 0x3f, 0xe9, 0x20, 0x03, 0xca, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x03, \
0xfe, 0xff, 0xff, 0x87, 0xfe, 0xff, 0xff, 0x07, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
0xb3, 0x04, 0x03, 0xb4, 0xb5, 0x00, 0x05, 0xb0, \
0x2a, 0x08, 0x03, 0x21, 0x00, 0x00, 0x00, 0x00, \
0x81, 0x00, 0x05, 0x84, 0x31, 0x04, 0x03, 0x36, \
0xc1, 0x00, 0x05, 0xc4, 0x07, 0x04, 0x03, 0x00, \
0x0d, 0x00, 0x00, 0x0d, 0x07, 0x04, 0x03, 0x00, \
0x0c, 0x00, 0x00, 0x0c, 0x94, 0x04, 0x03, 0x93, \
0xe1, 0x00, 0x05, 0xe4, 0xe7, 0x00, 0x03, 0xe4, \
0x93, 0x00, 0x03, 0x90, 0xa3, 0x00, 0x03, 0xa0, \
0xdc, 0x04, 0x00, 0xd8, 0x00, 0x00, 0x00, 0x00

#endif
