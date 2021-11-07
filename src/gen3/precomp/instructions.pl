$VAR1 = {
          'any' => {
                     'instr' => 996,
                     'mnem' => 'any',
                     'mode' => 0,
                     'opcode' => '000003e4',
                     'size' => 4
                   },
          'backcommit' => {
                            'instr' => 263104,
                            'mnem' => 'backcommit',
                            'mode' => 0,
                            'opcode' => '000403c0',
                            'param1' => 'address',
                            'size' => 8,
                            'terse' => 1
                          },
          'call' => {
                      'instr' => 263042,
                      'mnem' => 'call',
                      'mode' => 0,
                      'opcode' => '00040382',
                      'param1' => 'address',
                      'size' => 8,
                      'terse' => 1
                    },
          'catch' => {
                       'instr' => 263059,
                       'mnem' => 'catch',
                       'mode' => 0,
                       'opcode' => '00040393',
                       'param1' => 'address',
                       'size' => 8,
                       'terse' => 1
                     },
          'char' => {
                      'instr' => 263127,
                      'mnem' => 'char',
                      'mode' => 0,
                      'opcode' => '000403d7',
                      'param1' => 'char',
                      'size' => 8
                    },
          'closecapture' => {
                              'instr' => 262912,
                              'mnem' => 'closecapture',
                              'mode' => 0,
                              'opcode' => '00040300',
                              'param1' => 'slot',
                              'size' => 8,
                              'terse' => 1
                            },
          'commit' => {
                        'instr' => 262966,
                        'mnem' => 'commit',
                        'mode' => 0,
                        'opcode' => '00040336',
                        'param1' => 'address',
                        'size' => 8,
                        'terse' => 1
                      },
          'condjump' => {
                          'instr' => 525089,
                          'mnem' => 'condjump',
                          'opcode' => '00080321',
                          'param1' => 'register',
                          'param2' => 'address',
                          'size' => 12
                        },
          'counter' => {
                         'instr' => 525142,
                         'mnem' => 'counter',
                         'mode' => 0,
                         'opcode' => '00080356',
                         'param1' => 'register',
                         'param2' => 'value',
                         'size' => 12
                       },
          'end' => {
                     'instr' => 262360,
                     'mnem' => 'end',
                     'mode' => 'both',
                     'opcode' => '000400d8',
                     'param1' => 'code',
                     'size' => 8,
                     'terse' => 1
                   },
          'endisolate' => {
                            'instr' => 12293,
                            'mnem' => 'endisolate',
                            'mode' => 0,
                            'opcode' => '00003005',
                            'size' => 4,
                            'terse' => 0
                          },
          'endreplace' => {
                            'instr' => 921,
                            'mnem' => 'endreplace',
                            'mode' => 0,
                            'opcode' => '00000399',
                            'size' => 4,
                            'terse' => 1
                          },
          'fail' => {
                      'instr' => 843,
                      'mnem' => 'fail',
                      'mode' => 0,
                      'opcode' => '0000034b',
                      'size' => 4,
                      'terse' => 1
                    },
          'failtwice' => {
                           'instr' => 912,
                           'mnem' => 'failtwice',
                           'mode' => 0,
                           'opcode' => '00000390',
                           'size' => 4
                         },
          'intrpcapture' => {
                              'instr' => 524303,
                              'mnem' => 'intrpcapture',
                              'opcode' => '0008000f',
                              'size' => 12
                            },
          'isolate' => {
                         'instr' => 274435,
                         'mnem' => 'isolate',
                         'mode' => 0,
                         'opcode' => '00043003',
                         'param1' => 'slot',
                         'size' => 8,
                         'terse' => 0
                       },
          'jump' => {
                      'instr' => 262963,
                      'mnem' => 'jump',
                      'mode' => 'both',
                      'opcode' => '00040333',
                      'param1' => 'address',
                      'size' => 8,
                      'terse' => 1
                    },
          'maskedchar' => {
                            'instr' => 525157,
                            'mnem' => 'maskedchar',
                            'mode' => 0,
                            'opcode' => '00080365',
                            'param1' => 'char',
                            'param2' => 'mask',
                            'size' => 12,
                            'terse' => 1
                          },
          'mode' => {
                      'instr' => 262154,
                      'mnem' => 'mode',
                      'mode' => 'both',
                      'opcode' => '0004000a',
                      'size' => 8
                    },
          'noop' => {
                      'instr' => 0,
                      'mnem' => 'noop',
                      'mode' => 'both',
                      'opcode' => '00000000',
                      'size' => 4
                    },
          'opencapture' => {
                             'instr' => 263068,
                             'mnem' => 'opencapture',
                             'mode' => 0,
                             'opcode' => '0004039c',
                             'param1' => 'slot',
                             'size' => 8,
                             'terse' => 1
                           },
          'partialcommit' => {
                               'instr' => 263092,
                               'mnem' => 'partialcommit',
                               'mode' => 0,
                               'opcode' => '000403b4',
                               'param1' => 'address',
                               'size' => 8
                             },
          'quad' => {
                      'instr' => 263038,
                      'mnem' => 'quad',
                      'mode' => 0,
                      'opcode' => '0004037e',
                      'param1' => 'quad',
                      'size' => 8
                    },
          'range' => {
                       'instr' => 525245,
                       'mnem' => 'range',
                       'mode' => 0,
                       'opcode' => '000803bd',
                       'param1' => 'from',
                       'param2' => 'until',
                       'size' => 12,
                       'terse' => 1
                     },
          'replace' => {
                         'instr' => 525128,
                         'mnem' => 'replace',
                         'mode' => 0,
                         'opcode' => '00080348',
                         'param1' => 'slot',
                         'param2' => 'address',
                         'size' => 12,
                         'terse' => 1
                       },
          'ret' => {
                     'instr' => 928,
                     'mnem' => 'ret',
                     'mode' => 0,
                     'opcode' => '000003a0',
                     'size' => 4,
                     'terse' => 1
                   },
          'scr_add' => {
                         'instr' => 1292,
                         'mnem' => 'scr_add',
                         'mode' => 1,
                         'opcode' => '0000050c',
                         'size' => 4
                       },
          'scr_array' => {
                           'instr' => 262150,
                           'mnem' => 'scr_array',
                           'mode' => 1,
                           'opcode' => '00040006',
                           'size' => 8
                         },
          'scr_assign' => {
                            'instr' => 1481,
                            'mnem' => 'scr_assign',
                            'mode' => 1,
                            'opcode' => '000005c9',
                            'size' => 4
                          },
          'scr_bitand' => {
                            'instr' => 1319,
                            'mnem' => 'scr_bitand',
                            'mode' => 1,
                            'opcode' => '00000527',
                            'size' => 4
                          },
          'scr_bitnot' => {
                            'instr' => 1396,
                            'mnem' => 'scr_bitnot',
                            'mode' => 1,
                            'opcode' => '00000574',
                            'size' => 4
                          },
          'scr_bitor' => {
                           'instr' => 1340,
                           'mnem' => 'scr_bitor',
                           'mode' => 1,
                           'opcode' => '0000053c',
                           'size' => 4
                         },
          'scr_bitxor' => {
                            'instr' => 1325,
                            'mnem' => 'scr_bitxor',
                            'mode' => 1,
                            'opcode' => '0000052d',
                            'size' => 4
                          },
          'scr_builtin' => {
                             'instr' => 264143,
                             'mnem' => 'scr_builtin',
                             'mode' => 1,
                             'opcode' => '000407cf',
                             'size' => 8
                           },
          'scr_call' => {
                          'instr' => 263427,
                          'mnem' => 'scr_call',
                          'mode' => 1,
                          'opcode' => '00040503',
                          'size' => 8
                        },
          'scr_condjump' => {
                              'instr' => 262156,
                              'mnem' => 'scr_condjump',
                              'mode' => 1,
                              'opcode' => '0004000c',
                              'size' => 8
                            },
          'scr_dec' => {
                         'instr' => 1338,
                         'mnem' => 'scr_dec',
                         'mode' => 1,
                         'opcode' => '0000053a',
                         'size' => 4
                       },
          'scr_div' => {
                         'instr' => 1409,
                         'mnem' => 'scr_div',
                         'mode' => 1,
                         'opcode' => '00000581',
                         'size' => 4
                       },
          'scr_equals' => {
                            'instr' => 1388,
                            'mnem' => 'scr_equals',
                            'mode' => 1,
                            'opcode' => '0000056c',
                            'size' => 4
                          },
          'scr_gt' => {
                        'instr' => 1391,
                        'mnem' => 'scr_gt',
                        'mode' => 1,
                        'opcode' => '0000056f',
                        'size' => 4
                      },
          'scr_gteq' => {
                          'instr' => 1357,
                          'mnem' => 'scr_gteq',
                          'mode' => 1,
                          'opcode' => '0000054d',
                          'size' => 4
                        },
          'scr_inc' => {
                         'instr' => 1526,
                         'mnem' => 'scr_inc',
                         'mode' => 1,
                         'opcode' => '000005f6',
                         'size' => 4
                       },
          'scr_index' => {
                           'instr' => 9,
                           'mnem' => 'scr_index',
                           'opcode' => '00000009',
                           'size' => 4
                         },
          'scr_logand' => {
                            'instr' => 1326,
                            'mnem' => 'scr_logand',
                            'mode' => 1,
                            'opcode' => '0000052e',
                            'size' => 4
                          },
          'scr_lognot' => {
                            'instr' => 1529,
                            'mnem' => 'scr_lognot',
                            'mode' => 1,
                            'opcode' => '000005f9',
                            'size' => 4
                          },
          'scr_logor' => {
                           'instr' => 1449,
                           'mnem' => 'scr_logor',
                           'mode' => 1,
                           'opcode' => '000005a9',
                           'size' => 4
                         },
          'scr_lt' => {
                        'instr' => 1429,
                        'mnem' => 'scr_lt',
                        'mode' => 1,
                        'opcode' => '00000595',
                        'size' => 4
                      },
          'scr_lteq' => {
                          'instr' => 1314,
                          'mnem' => 'scr_lteq',
                          'mode' => 1,
                          'opcode' => '00000522',
                          'size' => 4
                        },
          'scr_mul' => {
                         'instr' => 1419,
                         'mnem' => 'scr_mul',
                         'mode' => 1,
                         'opcode' => '0000058b',
                         'size' => 4
                       },
          'scr_nequals' => {
                             'instr' => 1394,
                             'mnem' => 'scr_nequals',
                             'mode' => 1,
                             'opcode' => '00000572',
                             'size' => 4
                           },
          'scr_pop' => {
                         'instr' => 1484,
                         'mnem' => 'scr_pop',
                         'mode' => 1,
                         'opcode' => '000005cc',
                         'size' => 4
                       },
          'scr_pow' => {
                         'instr' => 1346,
                         'mnem' => 'scr_pow',
                         'mode' => 1,
                         'opcode' => '00000542',
                         'size' => 4
                       },
          'scr_push' => {
                          'instr' => 786435,
                          'mnem' => 'scr_push',
                          'mode' => 1,
                          'opcode' => '000c0003',
                          'size' => 16
                        },
          'scr_ret' => {
                         'instr' => 1365,
                         'mnem' => 'scr_ret',
                         'mode' => 1,
                         'opcode' => '00000555',
                         'size' => 4
                       },
          'scr_shift' => {
                           'instr' => 262149,
                           'mnem' => 'scr_shift',
                           'mode' => 1,
                           'opcode' => '00040005',
                           'size' => 8
                         },
          'scr_shiftin' => {
                             'instr' => 1405,
                             'mnem' => 'scr_shiftin',
                             'mode' => 1,
                             'opcode' => '0000057d',
                             'size' => 4
                           },
          'scr_shiftout' => {
                              'instr' => 1303,
                              'mnem' => 'scr_shiftout',
                              'mode' => 1,
                              'opcode' => '00000517',
                              'size' => 4
                            },
          'scr_string' => {
                            'instr' => 6075,
                            'mnem' => 'scr_sub',
                            'mode' => 1,
                            'opcode' => '000017bb',
                            'size' => 4
                          },
          'scr_sub' => {
                         'instr' => 1467,
                         'mnem' => 'scr_sub',
                         'mode' => 1,
                         'opcode' => '000005bb',
                         'size' => 4
                       },
          'set' => {
                     'instr' => 2098122,
                     'mnem' => 'set',
                     'mode' => 0,
                     'opcode' => '002003ca',
                     'param1' => 'set',
                     'size' => 36,
                     'terse' => 1
                   },
          'skip' => {
                      'instr' => 262960,
                      'mnem' => 'skip',
                      'mode' => 0,
                      'opcode' => '00040330',
                      'param1' => 'number',
                      'size' => 8
                    },
          'span' => {
                      'instr' => 2098145,
                      'mnem' => 'span',
                      'mode' => 0,
                      'opcode' => '002003e1',
                      'param1' => 'set',
                      'size' => 36
                    },
          'testany' => {
                         'instr' => 262918,
                         'mnem' => 'testany',
                         'mode' => 0,
                         'opcode' => '00040306',
                         'param1' => 'address',
                         'size' => 8
                       },
          'testchar' => {
                          'instr' => 525210,
                          'mnem' => 'testchar',
                          'mode' => 0,
                          'opcode' => '0008039a',
                          'param1' => 'address',
                          'param2' => 'char',
                          'size' => 12
                        },
          'testquad' => {
                          'instr' => 525275,
                          'mnem' => 'testquad',
                          'mode' => 0,
                          'opcode' => '000803db',
                          'param1' => 'address',
                          'param2' => 'quad',
                          'size' => 12
                        },
          'testset' => {
                         'instr' => 2360163,
                         'mnem' => 'testset',
                         'mode' => 0,
                         'opcode' => '00240363',
                         'param1' => 'address',
                         'param2' => 'set',
                         'size' => 40
                       },
          'trap' => {
                      'instr' => 4278255615,
                      'mnem' => 'trap',
                      'mode' => 'both',
                      'opcode' => 'ff00ffff',
                      'size' => 4
                    },
          'var' => {
                     'instr' => 263150,
                     'mnem' => 'var',
                     'mode' => 0,
                     'opcode' => '000403ee',
                     'param1' => 'slot',
                     'size' => 8,
                     'terse' => 1
                   }
        };
