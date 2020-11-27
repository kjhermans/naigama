$VAR1 = {
          'any' => {
                     'instr' => 996,
                     'mnem' => 'any',
                     'opcode' => '000003e4',
                     'size' => 4
                   },
          'backcommit' => {
                            'instr' => 263104,
                            'mnem' => 'backcommit',
                            'opcode' => '000403c0',
                            'param1' => 'address',
                            'size' => 8,
                            'terse' => 1
                          },
          'call' => {
                      'instr' => 263042,
                      'mnem' => 'call',
                      'opcode' => '00040382',
                      'param1' => 'address',
                      'size' => 8,
                      'terse' => 1
                    },
          'catch' => {
                       'instr' => 263059,
                       'mnem' => 'catch',
                       'opcode' => '00040393',
                       'param1' => 'address',
                       'size' => 8,
                       'terse' => 1
                     },
          'char' => {
                      'instr' => 263127,
                      'mnem' => 'char',
                      'opcode' => '000403d7',
                      'param1' => 'char',
                      'size' => 8
                    },
          'closecapture' => {
                              'instr' => 262912,
                              'mnem' => 'closecapture',
                              'opcode' => '00040300',
                              'param1' => 'slot',
                              'size' => 8,
                              'terse' => 1
                            },
          'commit' => {
                        'instr' => 262966,
                        'mnem' => 'commit',
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
                         'opcode' => '00080356',
                         'param1' => 'register',
                         'param2' => 'value',
                         'size' => 12
                       },
          'end' => {
                     'instr' => 262360,
                     'mnem' => 'end',
                     'opcode' => '000400d8',
                     'param1' => 'code',
                     'size' => 8,
                     'terse' => 1
                   },
          'endreplace' => {
                            'instr' => 921,
                            'mnem' => 'endreplace',
                            'opcode' => '00000399',
                            'size' => 4,
                            'terse' => 1
                          },
          'fail' => {
                      'instr' => 843,
                      'mnem' => 'fail',
                      'opcode' => '0000034b',
                      'size' => 4,
                      'terse' => 1
                    },
          'failtwice' => {
                           'instr' => 912,
                           'mnem' => 'failtwice',
                           'opcode' => '00000390',
                           'size' => 4
                         },
          'jump' => {
                      'instr' => 262963,
                      'mnem' => 'jump',
                      'opcode' => '00040333',
                      'param1' => 'address',
                      'size' => 8,
                      'terse' => 1
                    },
          'maskedchar' => {
                            'instr' => 525157,
                            'mnem' => 'maskedchar',
                            'opcode' => '00080365',
                            'param1' => 'char',
                            'param2' => 'mask',
                            'size' => 12,
                            'terse' => 1
                          },
          'noop' => {
                      'instr' => 0,
                      'mnem' => 'noop',
                      'opcode' => '00000000',
                      'size' => 4
                    },
          'opencapture' => {
                             'instr' => 263068,
                             'mnem' => 'opencapture',
                             'opcode' => '0004039c',
                             'param1' => 'slot',
                             'size' => 8,
                             'terse' => 1
                           },
          'partialcommit' => {
                               'instr' => 263092,
                               'mnem' => 'partialcommit',
                               'opcode' => '000403b4',
                               'param1' => 'address',
                               'size' => 8
                             },
          'quad' => {
                      'instr' => 263038,
                      'mnem' => 'quad',
                      'opcode' => '0004037e',
                      'param1' => 'quad',
                      'size' => 8
                    },
          'range' => {
                       'instr' => 525245,
                       'mnem' => 'range',
                       'opcode' => '000803bd',
                       'param1' => 'from',
                       'param2' => 'until',
                       'size' => 12,
                       'terse' => 1
                     },
          'replace' => {
                         'instr' => 525128,
                         'mnem' => 'replace',
                         'opcode' => '00080348',
                         'param1' => 'slot',
                         'param2' => 'address',
                         'size' => 12,
                         'terse' => 1
                       },
          'ret' => {
                     'instr' => 928,
                     'mnem' => 'ret',
                     'opcode' => '000003a0',
                     'size' => 4,
                     'terse' => 1
                   },
          'scr_add' => {
                         'instr' => 1292,
                         'mnem' => 'scr_add',
                         'opcode' => '0000050c',
                         'size' => 4
                       },
          'scr_assign' => {
                            'instr' => 1481,
                            'mnem' => 'scr_assign',
                            'opcode' => '000005c9',
                            'size' => 4
                          },
          'scr_bitand' => {
                            'instr' => 1319,
                            'mnem' => 'scr_bitand',
                            'opcode' => '00000527',
                            'size' => 4
                          },
          'scr_bitandis' => {
                              'instr' => 1316,
                              'mnem' => 'scr_bitandis',
                              'opcode' => '00000524',
                              'size' => 4
                            },
          'scr_bitnot' => {
                            'instr' => 1396,
                            'mnem' => 'scr_bitnot',
                            'opcode' => '00000574',
                            'size' => 4
                          },
          'scr_bitnotis' => {
                              'instr' => 1489,
                              'mnem' => 'scr_bitnotis',
                              'opcode' => '000005d1',
                              'size' => 4
                            },
          'scr_bitor' => {
                           'instr' => 1340,
                           'mnem' => 'scr_bitor',
                           'opcode' => '0000053c',
                           'size' => 4
                         },
          'scr_bitoris' => {
                             'instr' => 1375,
                             'mnem' => 'scr_bitoris',
                             'opcode' => '0000055f',
                             'size' => 4
                           },
          'scr_bitxor' => {
                            'instr' => 1325,
                            'mnem' => 'scr_bitxor',
                            'opcode' => '0000052d',
                            'size' => 4
                          },
          'scr_bitxoris' => {
                              'instr' => 1487,
                              'mnem' => 'scr_bitxoris',
                              'opcode' => '000005cf',
                              'size' => 4
                            },
          'scr_call' => {
                          'instr' => 263427,
                          'mnem' => 'scr_call',
                          'opcode' => '00040503',
                          'size' => 8
                        },
          'scr_condjump' => {
                              'instr' => 525799,
                              'mnem' => 'scr_condjump',
                              'opcode' => '000805e7',
                              'size' => 12
                            },
          'scr_dec' => {
                         'instr' => 1338,
                         'mnem' => 'scr_dec',
                         'opcode' => '0000053a',
                         'size' => 4
                       },
          'scr_div' => {
                         'instr' => 1409,
                         'mnem' => 'scr_div',
                         'opcode' => '00000581',
                         'size' => 4
                       },
          'scr_equals' => {
                            'instr' => 1388,
                            'mnem' => 'scr_equals',
                            'opcode' => '0000056c',
                            'size' => 4
                          },
          'scr_gt' => {
                        'instr' => 1391,
                        'mnem' => 'scr_gt',
                        'opcode' => '0000056f',
                        'size' => 4
                      },
          'scr_gteq' => {
                          'instr' => 1357,
                          'mnem' => 'scr_gteq',
                          'opcode' => '0000054d',
                          'size' => 4
                        },
          'scr_inc' => {
                         'instr' => 1526,
                         'mnem' => 'scr_inc',
                         'opcode' => '000005f6',
                         'size' => 4
                       },
          'scr_jump' => {
                          'instr' => 263664,
                          'mnem' => 'scr_jump',
                          'opcode' => '000405f0',
                          'size' => 8
                        },
          'scr_logand' => {
                            'instr' => 1326,
                            'mnem' => 'scr_logand',
                            'opcode' => '0000052e',
                            'size' => 4
                          },
          'scr_lognot' => {
                            'instr' => 1529,
                            'mnem' => 'scr_lognot',
                            'opcode' => '000005f9',
                            'size' => 4
                          },
          'scr_logor' => {
                           'instr' => 1449,
                           'mnem' => 'scr_logor',
                           'opcode' => '000005a9',
                           'size' => 4
                         },
          'scr_lt' => {
                        'instr' => 1429,
                        'mnem' => 'scr_lt',
                        'opcode' => '00000595',
                        'size' => 4
                      },
          'scr_lteq' => {
                          'instr' => 1314,
                          'mnem' => 'scr_lteq',
                          'opcode' => '00000522',
                          'size' => 4
                        },
          'scr_mul' => {
                         'instr' => 1419,
                         'mnem' => 'scr_mul',
                         'opcode' => '0000058b',
                         'size' => 4
                       },
          'scr_nequals' => {
                             'instr' => 1394,
                             'mnem' => 'scr_nequals',
                             'opcode' => '00000572',
                             'size' => 4
                           },
          'scr_pop' => {
                         'instr' => 1484,
                         'mnem' => 'scr_pop',
                         'opcode' => '000005cc',
                         'size' => 4
                       },
          'scr_pow' => {
                         'instr' => 1346,
                         'mnem' => 'scr_pow',
                         'opcode' => '00000542',
                         'size' => 4
                       },
          'scr_push' => {
                          'instr' => 1517,
                          'mnem' => 'scr_push',
                          'opcode' => '000005ed',
                          'size' => 4
                        },
          'scr_ret' => {
                         'instr' => 1365,
                         'mnem' => 'scr_ret',
                         'opcode' => '00000555',
                         'size' => 4
                       },
          'scr_shiftin' => {
                             'instr' => 1405,
                             'mnem' => 'scr_shiftin',
                             'opcode' => '0000057d',
                             'size' => 4
                           },
          'scr_shiftinis' => {
                               'instr' => 1399,
                               'mnem' => 'scr_shiftinis',
                               'opcode' => '00000577',
                               'size' => 4
                             },
          'scr_shiftout' => {
                              'instr' => 1303,
                              'mnem' => 'scr_shiftout',
                              'opcode' => '00000517',
                              'size' => 4
                            },
          'scr_shiftoutis' => {
                                'instr' => 1502,
                                'mnem' => 'scr_shiftoutis',
                                'opcode' => '000005de',
                                'size' => 4
                              },
          'scr_sub' => {
                         'instr' => 1467,
                         'mnem' => 'scr_sub',
                         'opcode' => '000005bb',
                         'size' => 4
                       },
          'set' => {
                     'instr' => 2098122,
                     'mnem' => 'set',
                     'opcode' => '002003ca',
                     'param1' => 'set',
                     'size' => 36,
                     'terse' => 1
                   },
          'skip' => {
                      'instr' => 262960,
                      'mnem' => 'skip',
                      'opcode' => '00040330',
                      'param1' => 'number',
                      'size' => 8
                    },
          'span' => {
                      'instr' => 2098145,
                      'mnem' => 'span',
                      'opcode' => '002003e1',
                      'param1' => 'set',
                      'size' => 36
                    },
          'testany' => {
                         'instr' => 262918,
                         'mnem' => 'testany',
                         'opcode' => '00040306',
                         'param1' => 'address',
                         'size' => 8
                       },
          'testchar' => {
                          'instr' => 525210,
                          'mnem' => 'testchar',
                          'opcode' => '0008039a',
                          'param1' => 'address',
                          'param2' => 'char',
                          'size' => 12
                        },
          'testquad' => {
                          'instr' => 525275,
                          'mnem' => 'testquad',
                          'opcode' => '000803db',
                          'param1' => 'address',
                          'param2' => 'quad',
                          'size' => 12
                        },
          'testset' => {
                         'instr' => 2360163,
                         'mnem' => 'testset',
                         'opcode' => '00240363',
                         'param1' => 'address',
                         'param2' => 'set',
                         'size' => 40
                       },
          'trap' => {
                      'instr' => 4278255615,
                      'mnem' => 'trap',
                      'opcode' => 'ff00ffff',
                      'size' => 4
                    },
          'var' => {
                     'instr' => 263150,
                     'mnem' => 'var',
                     'opcode' => '000403ee',
                     'param1' => 'slot',
                     'size' => 8,
                     'terse' => 1
                   },
          'isolate' => {
                     'instr' => 274435,
                     'mnem' => 'isolate',
                     'opcode' => '00043003',
                     'param1' => 'slot',
                     'size' => 8,
                     'terse' => 0
          },
          'endisolate' => {
                     'instr' => 12293,
                     'mnem' => 'endisolate',
                     'opcode' => '00003005',
                     'size' => 4,
                     'terse' => 0
          },
        };
