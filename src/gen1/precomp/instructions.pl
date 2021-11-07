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
                   }
        };
