$VAR1 = {
          'any' => {
                     'instr' => 801,
                     'mnem' => 'any',
                     'opcode' => '00000321',
                     'size' => 4
                   },
          'backcommit' => {
                            'instr' => 263116,
                            'mnem' => 'backcommit',
                            'opcode' => '000403cc',
                            'param1' => 'address',
                            'size' => 8,
                            'terse' => 1
                          },
          'call' => {
                      'instr' => 262963,
                      'mnem' => 'call',
                      'opcode' => '00040333',
                      'param1' => 'address',
                      'size' => 8,
                      'terse' => 1
                    },
          'catch' => {
                       'instr' => 263138,
                       'mnem' => 'catch',
                       'opcode' => '000403e2',
                       'param1' => 'address',
                       'size' => 8,
                       'terse' => 1
                     },
          'char' => {
                      'instr' => 263133,
                      'mnem' => 'char',
                      'opcode' => '000403dd',
                      'param1' => 'char',
                      'size' => 8
                    },
          'closecapture' => {
                              'instr' => 263017,
                              'mnem' => 'closecapture',
                              'opcode' => '00040369',
                              'param1' => 'slot',
                              'size' => 8,
                              'terse' => 1
                            },
          'commit' => {
                        'instr' => 263128,
                        'mnem' => 'commit',
                        'opcode' => '000403d8',
                        'param1' => 'address',
                        'size' => 8,
                        'terse' => 1
                      },
          'condjump' => {
                          'instr' => 525128,
                          'mnem' => 'condjump',
                          'opcode' => '00080348',
                          'param1' => 'register',
                          'param2' => 'address',
                          'size' => 12
                        },
          'counter' => {
                         'instr' => 525263,
                         'mnem' => 'counter',
                         'opcode' => '000803cf',
                         'param1' => 'register',
                         'param2' => 'value',
                         'size' => 12
                       },
          'end' => {
                     'instr' => 262309,
                     'mnem' => 'end',
                     'opcode' => '000400a5',
                     'param1' => 'code',
                     'size' => 8,
                     'terse' => 1
                   },
          'endreplace' => {
                            'instr' => 969,
                            'mnem' => 'endreplace',
                            'opcode' => '000003c9',
                            'size' => 4,
                            'terse' => 1
                          },
          'fail' => {
                      'instr' => 802,
                      'mnem' => 'fail',
                      'opcode' => '00000322',
                      'size' => 4,
                      'terse' => 1
                    },
          'failtwice' => {
                           'instr' => 813,
                           'mnem' => 'failtwice',
                           'opcode' => '0000032d',
                           'size' => 4
                         },
          'jump' => {
                      'instr' => 262965,
                      'mnem' => 'jump',
                      'opcode' => '00040335',
                      'param1' => 'address',
                      'size' => 8,
                      'terse' => 1
                    },
          'maskedchar' => {
                            'instr' => 525275,
                            'mnem' => 'maskedchar',
                            'opcode' => '000803db',
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
                             'instr' => 263092,
                             'mnem' => 'opencapture',
                             'opcode' => '000403b4',
                             'param1' => 'slot',
                             'size' => 8,
                             'terse' => 1
                           },
          'partialcommit' => {
                               'instr' => 263013,
                               'mnem' => 'partialcommit',
                               'opcode' => '00040365',
                               'param1' => 'address',
                               'size' => 8
                             },
          'quad' => {
                      'instr' => 263075,
                      'mnem' => 'quad',
                      'opcode' => '000403a3',
                      'param1' => 'quad',
                      'size' => 8
                    },
          'range' => {
                       'instr' => 525203,
                       'mnem' => 'range',
                       'opcode' => '00080393',
                       'param1' => 'from',
                       'param2' => 'until',
                       'size' => 12,
                       'terse' => 1
                     },
          'replace' => {
                         'instr' => 525179,
                         'mnem' => 'replace',
                         'opcode' => '0008037b',
                         'param1' => 'slot',
                         'param2' => 'address',
                         'size' => 12,
                         'terse' => 1
                       },
          'ret' => {
                     'instr' => 828,
                     'mnem' => 'ret',
                     'opcode' => '0000033c',
                     'size' => 4,
                     'terse' => 1
                   },
          'scr_add' => {
                         'instr' => 1319,
                         'mnem' => 'scr_add',
                         'opcode' => '00000527',
                         'size' => 4
                       },
          'scr_assign' => {
                            'instr' => 1440,
                            'mnem' => 'scr_assign',
                            'opcode' => '000005a0',
                            'size' => 4
                          },
          'scr_bitand' => {
                            'instr' => 1396,
                            'mnem' => 'scr_bitand',
                            'opcode' => '00000574',
                            'size' => 4
                          },
          'scr_bitandis' => {
                              'instr' => 1430,
                              'mnem' => 'scr_bitandis',
                              'opcode' => '00000596',
                              'size' => 4
                            },
          'scr_bitnot' => {
                            'instr' => 1446,
                            'mnem' => 'scr_bitnot',
                            'opcode' => '000005a6',
                            'size' => 4
                          },
          'scr_bitnotis' => {
                              'instr' => 1370,
                              'mnem' => 'scr_bitnotis',
                              'opcode' => '0000055a',
                              'size' => 4
                            },
          'scr_bitor' => {
                           'instr' => 1489,
                           'mnem' => 'scr_bitor',
                           'opcode' => '000005d1',
                           'size' => 4
                         },
          'scr_bitoris' => {
                             'instr' => 1532,
                             'mnem' => 'scr_bitoris',
                             'opcode' => '000005fc',
                             'size' => 4
                           },
          'scr_bitxor' => {
                            'instr' => 1280,
                            'mnem' => 'scr_bitxor',
                            'opcode' => '00000500',
                            'size' => 4
                          },
          'scr_bitxoris' => {
                              'instr' => 1525,
                              'mnem' => 'scr_bitxoris',
                              'opcode' => '000005f5',
                              'size' => 4
                            },
          'scr_call' => {
                          'instr' => 263447,
                          'mnem' => 'scr_call',
                          'opcode' => '00040517',
                          'size' => 8
                        },
          'scr_condjump' => {
                              'instr' => 525660,
                              'mnem' => 'scr_condjump',
                              'opcode' => '0008055c',
                              'size' => 12
                            },
          'scr_dec' => {
                         'instr' => 1376,
                         'mnem' => 'scr_dec',
                         'opcode' => '00000560',
                         'size' => 4
                       },
          'scr_div' => {
                         'instr' => 1422,
                         'mnem' => 'scr_div',
                         'opcode' => '0000058e',
                         'size' => 4
                       },
          'scr_equals' => {
                            'instr' => 1304,
                            'mnem' => 'scr_equals',
                            'opcode' => '00000518',
                            'size' => 4
                          },
          'scr_gt' => {
                        'instr' => 1419,
                        'mnem' => 'scr_gt',
                        'opcode' => '0000058b',
                        'size' => 4
                      },
          'scr_gteq' => {
                          'instr' => 1463,
                          'mnem' => 'scr_gteq',
                          'opcode' => '000005b7',
                          'size' => 4
                        },
          'scr_inc' => {
                         'instr' => 1502,
                         'mnem' => 'scr_inc',
                         'opcode' => '000005de',
                         'size' => 4
                       },
          'scr_jump' => {
                          'instr' => 263580,
                          'mnem' => 'scr_jump',
                          'opcode' => '0004059c',
                          'size' => 8
                        },
          'scr_logand' => {
                            'instr' => 1357,
                            'mnem' => 'scr_logand',
                            'opcode' => '0000054d',
                            'size' => 4
                          },
          'scr_lognot' => {
                            'instr' => 1505,
                            'mnem' => 'scr_lognot',
                            'opcode' => '000005e1',
                            'size' => 4
                          },
          'scr_logor' => {
                           'instr' => 1365,
                           'mnem' => 'scr_logor',
                           'opcode' => '00000555',
                           'size' => 4
                         },
          'scr_lt' => {
                        'instr' => 1523,
                        'mnem' => 'scr_lt',
                        'opcode' => '000005f3',
                        'size' => 4
                      },
          'scr_lteq' => {
                          'instr' => 1323,
                          'mnem' => 'scr_lteq',
                          'opcode' => '0000052b',
                          'size' => 4
                        },
          'scr_mul' => {
                         'instr' => 1517,
                         'mnem' => 'scr_mul',
                         'opcode' => '000005ed',
                         'size' => 4
                       },
          'scr_nequals' => {
                             'instr' => 1450,
                             'mnem' => 'scr_nequals',
                             'opcode' => '000005aa',
                             'size' => 4
                           },
          'scr_pop' => {
                         'instr' => 1346,
                         'mnem' => 'scr_pop',
                         'opcode' => '00000542',
                         'size' => 4
                       },
          'scr_pow' => {
                         'instr' => 1475,
                         'mnem' => 'scr_pow',
                         'opcode' => '000005c3',
                         'size' => 4
                       },
          'scr_push' => {
                          'instr' => 1345,
                          'mnem' => 'scr_push',
                          'opcode' => '00000541',
                          'size' => 4
                        },
          'scr_ret' => {
                         'instr' => 1530,
                         'mnem' => 'scr_ret',
                         'opcode' => '000005fa',
                         'size' => 4
                       },
          'scr_shiftin' => {
                             'instr' => 1391,
                             'mnem' => 'scr_shiftin',
                             'opcode' => '0000056f',
                             'size' => 4
                           },
          'scr_shiftinis' => {
                               'instr' => 1375,
                               'mnem' => 'scr_shiftinis',
                               'opcode' => '0000055f',
                               'size' => 4
                             },
          'scr_shiftout' => {
                              'instr' => 1379,
                              'mnem' => 'scr_shiftout',
                              'opcode' => '00000563',
                              'size' => 4
                            },
          'scr_shiftoutis' => {
                                'instr' => 1482,
                                'mnem' => 'scr_shiftoutis',
                                'opcode' => '000005ca',
                                'size' => 4
                              },
          'scr_sub' => {
                         'instr' => 1429,
                         'mnem' => 'scr_sub',
                         'opcode' => '00000595',
                         'size' => 4
                       },
          'set' => {
                     'instr' => 2098169,
                     'mnem' => 'set',
                     'opcode' => '002003f9',
                     'param1' => 'set',
                     'size' => 36,
                     'terse' => 1
                   },
          'skip' => {
                      'instr' => 263102,
                      'mnem' => 'skip',
                      'opcode' => '000403be',
                      'param1' => 'number',
                      'size' => 8
                    },
          'span' => {
                      'instr' => 2098052,
                      'mnem' => 'span',
                      'opcode' => '00200384',
                      'param1' => 'set',
                      'size' => 36
                    },
          'testany' => {
                         'instr' => 262932,
                         'mnem' => 'testany',
                         'opcode' => '00040314',
                         'param1' => 'address',
                         'size' => 8
                       },
          'testchar' => {
                          'instr' => 525185,
                          'mnem' => 'testchar',
                          'opcode' => '00080381',
                          'param1' => 'address',
                          'param2' => 'char',
                          'size' => 12
                        },
          'testquad' => {
                          'instr' => 525142,
                          'mnem' => 'testquad',
                          'opcode' => '00080356',
                          'param1' => 'address',
                          'param2' => 'quad',
                          'size' => 12
                        },
          'testset' => {
                         'instr' => 2360153,
                         'mnem' => 'testset',
                         'opcode' => '00240359',
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
                     'instr' => 263038,
                     'mnem' => 'var',
                     'opcode' => '0004037e',
                     'param1' => 'slot',
                     'size' => 8,
                     'terse' => 1
                   }
        };
