--
-- Naigama compiler library; gen 3; release 0.3.3
-- At Sat, 22 Jan 2022 23:51:12 +0100
--

  call CERTIFICATE
  end 0

__RULE_CERTIFICATE:
  opencapture 0
  call SEQUENCE
  call BERLENGTH
  intrpcapture ruint32 default
  call CERTCONTENT
__SUCCESS_1:
  closecapture 0
  ret -- CERTIFICATE

__RULE_BERLENGTH:
  opencapture 1
  catch __ALT_3
  catch __SCANNER_4
  maskedchar 00 80
  backcommit __SCANNER_4_OUT
__SCANNER_4:
  fail
__SCANNER_4_OUT:
  opencapture 2
  any
__SUCCESS_5:
  closecapture 2
  commit __SUCCESS_2
__ALT_3:
  catch __ALT_6
  char 81
  opencapture 3
  any
__SUCCESS_7:
  closecapture 3
  commit __SUCCESS_2
__ALT_6:
  catch __ALT_8
  char 82
  opencapture 4
  any
  any
__SUCCESS_9:
  closecapture 4
  commit __SUCCESS_2
__ALT_8:
  catch __ALT_10
  char 83
  opencapture 5
  any
  any
  any
__SUCCESS_11:
  closecapture 5
  commit __SUCCESS_2
__ALT_10:
  char 84
  opencapture 6
  any
  any
  any
  any
__SUCCESS_12:
  closecapture 6
__SUCCESS_2:
  closecapture 1
  ret -- BERLENGTH

__RULE_CERTCONTENT:
  opencapture 7
  call TBSCERTIFICATE
  call SIGNATUREALGORITHM
  call SIGNATUREVALUE
__SUCCESS_13:
  closecapture 7
  ret -- CERTCONTENT

__RULE_TBSCERTIFICATE:
  opencapture 8
  call SEQUENCE
  call BERLENGTH
  intrpcapture ruint32 default
  call TBSCERTCONTENT
__SUCCESS_14:
  closecapture 8
  ret -- TBSCERTIFICATE

__RULE_TBSCERTCONTENT:
  opencapture 9
  call VERSION
  call SERIALNUMBER
  call SIGNATURE
  call ISSUER
  call VALIDITY
  call SUBJECT
  call SUBJECTPUBKEYINFO
  catch __FORGIVE_16
  call ISSUERUNIQUEID
  commit __NEXT__
__FORGIVE_16:
__SUCCESS_15:
  closecapture 9
  ret -- TBSCERTCONTENT

__RULE_VERSION:
  opencapture 10
  call GCTXSPCLASS
__SUCCESS_18:
  closecapture 10
  ret -- VERSION

__RULE_SERIALNUMBER:
  opencapture 11
  call INTEGER
__SUCCESS_19:
  closecapture 11
  ret -- SERIALNUMBER

__RULE_SIGNATURE:
  opencapture 12
  call SEQUENCE
  call BERLENGTH
  intrpcapture ruint32 default
  call ALGIDENTCONT
__SUCCESS_20:
  closecapture 12
  ret -- SIGNATURE

__RULE_ALGIDENTCONT:
  opencapture 13
  call ALGORITHM
  catch __FORGIVE_22
  call PARAMETERS
  commit __NEXT__
__FORGIVE_22:
__SUCCESS_21:
  closecapture 13
  ret -- ALGIDENTCONT

__RULE_ALGORITHM:
  opencapture 14
  opencapture 15
  call OID
__SUCCESS_25:
  closecapture 15
__SUCCESS_24:
  closecapture 14
  ret -- ALGORITHM

__RULE_PARAMETERS:
  opencapture 16
  call ANY
__SUCCESS_26:
  closecapture 16
  ret -- PARAMETERS

__RULE_ISSUER:
  opencapture 17
  call SEQUENCE
  call BERLENGTH
  intrpcapture ruint32 default
  call ISSUERCONTENT
__SUCCESS_27:
  closecapture 17
  ret -- ISSUER

__RULE_ISSUERCONTENT:
  opencapture 18
  catch __FORGIVE_29
__FOREVER_30:
  opencapture 19
  call ISSUERNV
__SUCCESS_31:
  closecapture 19
  partialcommit __FOREVER_30
__FORGIVE_29:
__SUCCESS_28:
  closecapture 18
  ret -- ISSUERCONTENT

__RULE_ISSUERNV:
  opencapture 20
  call SET
  call BERLENGTH
  intrpcapture ruint32 default
  call ISSUERNV_
__SUCCESS_32:
  closecapture 20
  ret -- ISSUERNV

__RULE_ISSUERNV_:
  opencapture 21
  call SEQUENCE
  call BERLENGTH
  intrpcapture ruint32 default
  call ISSUERNV__
__SUCCESS_33:
  closecapture 21
  ret -- ISSUERNV_

__RULE_ISSUERNV__:
  opencapture 22
  call ISSUERNAME
  call ISSUERVALUE
__SUCCESS_34:
  closecapture 22
  ret -- ISSUERNV__

__RULE_ISSUERNAME:
  opencapture 23
  opencapture 24
  call OID
__SUCCESS_36:
  closecapture 24
__SUCCESS_35:
  closecapture 23
  ret -- ISSUERNAME

__RULE_ISSUERVALUE:
  opencapture 25
  opencapture 26
  call ANY
__SUCCESS_38:
  closecapture 26
__SUCCESS_37:
  closecapture 25
  ret -- ISSUERVALUE

__RULE_SIGNATUREALGORITHM:
  opencapture 27
  call SEQUENCE
  call BERLENGTH
  intrpcapture ruint32 default
  call SIGALGCONTENT
__SUCCESS_39:
  closecapture 27
  ret -- SIGNATUREALGORITHM

__RULE_SIGALGCONTENT:
  opencapture 28
  call OID
  catch __FORGIVE_41
  call ANY
  commit __NEXT__
__FORGIVE_41:
__SUCCESS_40:
  closecapture 28
  ret -- SIGALGCONTENT

__RULE_SIGNATUREVALUE:
  opencapture 29
  call BITSTRING
  call BERLENGTH
  intrpcapture ruint32 default
  call SIGVALCONTENT
__SUCCESS_43:
  closecapture 29
  ret -- SIGNATUREVALUE

__RULE_SIGVALCONTENT:
  opencapture 30
  any
  opencapture 31
  catch __FORGIVE_46
__FOREVER_47:
  any
  partialcommit __FOREVER_47
__FORGIVE_46:
__SUCCESS_45:
  closecapture 31
__SUCCESS_44:
  closecapture 30
  ret -- SIGVALCONTENT

__RULE_VALIDITY:
  opencapture 32
  call SEQUENCE
  call BERLENGTH
  intrpcapture ruint32 default
  call VALIDITYCONTENT
__SUCCESS_48:
  closecapture 32
  ret -- VALIDITY

__RULE_VALIDITYCONTENT:
  opencapture 33
  call VALIDFROM
  call VALIDUNTIL
__SUCCESS_49:
  closecapture 33
  ret -- VALIDITYCONTENT

__RULE_VALIDFROM:
  opencapture 34
  call TIMESTAMP
__SUCCESS_50:
  closecapture 34
  ret -- VALIDFROM

__RULE_VALIDUNTIL:
  opencapture 35
  call TIMESTAMP
__SUCCESS_51:
  closecapture 35
  ret -- VALIDUNTIL

__RULE_SUBJECT:
  opencapture 36
  call SEQUENCE
  call BERLENGTH
  intrpcapture ruint32 default
  call SUBJECTCONTENT
__SUCCESS_52:
  closecapture 36
  ret -- SUBJECT

__RULE_SUBJECTCONTENT:
  opencapture 37
  catch __FORGIVE_54
__FOREVER_55:
  call SUBJENTRY
  partialcommit __FOREVER_55
__FORGIVE_54:
__SUCCESS_53:
  closecapture 37
  ret -- SUBJECTCONTENT

__RULE_SUBJENTRY:
  opencapture 38
  call SET
  call BERLENGTH
  intrpcapture ruint32 default
  call SUBJENTRYNV_
__SUCCESS_56:
  closecapture 38
  ret -- SUBJENTRY

__RULE_SUBJENTRYNV_:
  opencapture 39
  call SEQUENCE
  call BERLENGTH
  intrpcapture ruint32 default
  call SUBJENTRYNV__
__SUCCESS_57:
  closecapture 39
  ret -- SUBJENTRYNV_

__RULE_SUBJENTRYNV__:
  opencapture 40
  call SUBJENTRYNAME
  call SUBJENTRYVALUE
__SUCCESS_58:
  closecapture 40
  ret -- SUBJENTRYNV__

__RULE_SUBJENTRYNAME:
  opencapture 41
  opencapture 42
  call OID
__SUCCESS_60:
  closecapture 42
__SUCCESS_59:
  closecapture 41
  ret -- SUBJENTRYNAME

__RULE_SUBJENTRYVALUE:
  opencapture 43
  opencapture 44
  call ANY
__SUCCESS_62:
  closecapture 44
__SUCCESS_61:
  closecapture 43
  ret -- SUBJENTRYVALUE

__RULE_SUBJECTPUBKEYINFO:
  opencapture 45
  call SEQUENCE
  call BERLENGTH
  intrpcapture ruint32 default
  call SPKICONTENT
__SUCCESS_63:
  closecapture 45
  ret -- SUBJECTPUBKEYINFO

__RULE_SPKICONTENT:
  opencapture 46
  catch __FORGIVE_65
__FOREVER_66:
  opencapture 47
  call ANY
__SUCCESS_67:
  closecapture 47
  partialcommit __FOREVER_66
__FORGIVE_65:
__SUCCESS_64:
  closecapture 46
  ret -- SPKICONTENT

__RULE_ISSUERUNIQUEID:
  opencapture 48
  call CTXSPCLASS
  call BERLENGTH
  intrpcapture ruint32 default
  call ISSUERUIDCONTENT
__SUCCESS_68:
  closecapture 48
  ret -- ISSUERUNIQUEID

__RULE_ISSUERUIDCONTENT:
  opencapture 49
  catch __FORGIVE_70
__FOREVER_71:
  opencapture 50
  call ANY
__SUCCESS_72:
  closecapture 50
  partialcommit __FOREVER_71
__FORGIVE_70:
__SUCCESS_69:
  closecapture 49
  ret -- ISSUERUIDCONTENT

__RULE_ANY:
  opencapture 51
  catch __ALT_74
  call GENERICLIST
  commit __SUCCESS_73
__ALT_74:
  catch __ALT_75
  call OID
  commit __SUCCESS_73
__ALT_75:
  catch __ALT_76
  call INTEGER
  commit __SUCCESS_73
__ALT_76:
  catch __ALT_77
  call IPV4
  commit __SUCCESS_73
__ALT_77:
  catch __ALT_78
  call NULL
  commit __SUCCESS_73
__ALT_78:
  catch __ALT_79
  call BSTRING
  commit __SUCCESS_73
__ALT_79:
  catch __ALT_80
  call PSTRING
  commit __SUCCESS_73
__ALT_80:
  catch __ALT_81
  call ISTRING
  commit __SUCCESS_73
__ALT_81:
  catch __ALT_82
  call USTRING
  commit __SUCCESS_73
__ALT_82:
  catch __ALT_83
  call OSTRING
  commit __SUCCESS_73
__ALT_83:
  catch __ALT_84
  call GENERICSET
  commit __SUCCESS_73
__ALT_84:
  catch __ALT_85
  call GCTXSPCLASS
  commit __SUCCESS_73
__ALT_85:
  catch __ALT_86
  call TIMESTAMP
  commit __SUCCESS_73
__ALT_86:
  call BOOLEAN
__SUCCESS_73:
  closecapture 51
  ret -- ANY

__RULE_GENERICLIST:
  opencapture 52
  call SEQUENCE
  call BERLENGTH
  intrpcapture ruint32 default
  call LISTCONTENT
__SUCCESS_87:
  closecapture 52
  ret -- GENERICLIST

__RULE_GENERICSET:
  opencapture 53
  call SET
  call BERLENGTH
  intrpcapture ruint32 default
  call LISTCONTENT
__SUCCESS_88:
  closecapture 53
  ret -- GENERICSET

__RULE_GCTXSPCLASS:
  opencapture 54
  call CTXSPCLASS
  call BERLENGTH
  intrpcapture ruint32 default
  call LISTCONTENT
__SUCCESS_89:
  closecapture 54
  ret -- GCTXSPCLASS

__RULE_LISTCONTENT:
  opencapture 55
  catch __FORGIVE_91
__FOREVER_92:
  opencapture 56
  call ANY
__SUCCESS_93:
  closecapture 56
  partialcommit __FOREVER_92
__FORGIVE_91:
__SUCCESS_90:
  closecapture 55
  ret -- LISTCONTENT

__RULE_SEQUENCE:
  opencapture 57
  char 30
__SUCCESS_94:
  closecapture 57
  ret -- SEQUENCE

__RULE_SET:
  opencapture 58
  char 31
__SUCCESS_95:
  closecapture 58
  ret -- SET

__RULE_CTXSPCLASS:
  opencapture 59
  catch __ALT_97
  char a3
  commit __SUCCESS_96
__ALT_97:
  char a0
__SUCCESS_96:
  closecapture 59
  ret -- CTXSPCLASS

__RULE_INTEGER:
  opencapture 60
  call INTEGERTYPE
  call BERLENGTH
  intrpcapture ruint32 default
  call INTEGERVALUE
__SUCCESS_98:
  closecapture 60
  ret -- INTEGER

__RULE_INTEGERTYPE:
  opencapture 61
  char 02
__SUCCESS_99:
  closecapture 61
  ret -- INTEGERTYPE

__RULE_INTEGERVALUE:
  opencapture 62
  opencapture 63
  catch __FORGIVE_102
__FOREVER_103:
  any
  partialcommit __FOREVER_103
__FORGIVE_102:
__SUCCESS_101:
  closecapture 63
__SUCCESS_100:
  closecapture 62
  ret -- INTEGERVALUE

__RULE_IPV4:
  opencapture 64
  char 40
  char 04
  opencapture 65
  any
  any
  any
  any
__SUCCESS_105:
  closecapture 65
__SUCCESS_104:
  closecapture 64
  ret -- IPV4

__RULE_NULL:
  opencapture 66
  char 05
  char 00
__SUCCESS_106:
  closecapture 66
  ret -- NULL

__RULE_BITSTRING:
  opencapture 67
  char 03
__SUCCESS_107:
  closecapture 67
  ret -- BITSTRING

__RULE_TIMESTAMP:
  opencapture 68
  char 17
  call BERLENGTH
  intrpcapture ruint32 default
  call TIMECONTENT
__SUCCESS_108:
  closecapture 68
  ret -- TIMESTAMP

__RULE_TIMECONTENT:
  opencapture 69
  opencapture 70
  catch __FORGIVE_111
__FOREVER_112:
  any
  partialcommit __FOREVER_112
__FORGIVE_111:
__SUCCESS_110:
  closecapture 70
__SUCCESS_109:
  closecapture 69
  ret -- TIMECONTENT

__RULE_BOOLEAN:
  opencapture 71
  char 01
  char 01
  opencapture 72
  any
__SUCCESS_114:
  closecapture 72
__SUCCESS_113:
  closecapture 71
  ret -- BOOLEAN

__RULE_PRINTABLESTRING:
  opencapture 73
  char 13
__SUCCESS_115:
  closecapture 73
  ret -- PRINTABLESTRING

__RULE_IASTRING:
  opencapture 74
  char 16
__SUCCESS_116:
  closecapture 74
  ret -- IASTRING

__RULE_UTF8STRING:
  opencapture 75
  char 0c
__SUCCESS_117:
  closecapture 75
  ret -- UTF8STRING

__RULE_OCTETSTRING:
  opencapture 76
  char 04
__SUCCESS_118:
  closecapture 76
  ret -- OCTETSTRING

__RULE_BSTRING:
  opencapture 77
  call BITSTRING
  call BERLENGTH
  intrpcapture ruint32 default
  call BSTRINGCNT
__SUCCESS_119:
  closecapture 77
  ret -- BSTRING

__RULE_PSTRING:
  opencapture 78
  call PRINTABLESTRING
  call BERLENGTH
  intrpcapture ruint32 default
  call STRINGCNT
__SUCCESS_120:
  closecapture 78
  ret -- PSTRING

__RULE_ISTRING:
  opencapture 79
  call IASTRING
  call BERLENGTH
  intrpcapture ruint32 default
  call STRINGCNT
__SUCCESS_121:
  closecapture 79
  ret -- ISTRING

__RULE_USTRING:
  opencapture 80
  call UTF8STRING
  call BERLENGTH
  intrpcapture ruint32 default
  call STRINGCNT
__SUCCESS_122:
  closecapture 80
  ret -- USTRING

__RULE_OSTRING:
  opencapture 81
  call OCTETSTRING
  call BERLENGTH
  intrpcapture ruint32 default
  call STRINGCNT
__SUCCESS_123:
  closecapture 81
  ret -- OSTRING

__RULE_STRINGCNT:
  opencapture 82
  opencapture 83
  catch __FORGIVE_126
__FOREVER_127:
  any
  partialcommit __FOREVER_127
__FORGIVE_126:
__SUCCESS_125:
  closecapture 83
__SUCCESS_124:
  closecapture 82
  ret -- STRINGCNT

__RULE_BSTRINGCNT:
  opencapture 84
  any
  opencapture 85
  catch __FORGIVE_130
__FOREVER_131:
  any
  partialcommit __FOREVER_131
__FORGIVE_130:
__SUCCESS_129:
  closecapture 85
__SUCCESS_128:
  closecapture 84
  ret -- BSTRINGCNT

__RULE_OID:
  opencapture 86
  char 06
  call BERLENGTH
  intrpcapture ruint32 default
  call OIDVALUE
__SUCCESS_132:
  closecapture 86
  ret -- OID

__RULE_OIDVALUE:
  opencapture 87
  opencapture 88
  opencapture 89
  any
__SUCCESS_135:
  closecapture 89
  catch __FORGIVE_136
__FOREVER_137:
  opencapture 90
  catch __FORGIVE_139
__FOREVER_140:
  maskedchar 80 80
  partialcommit __FOREVER_140
__FORGIVE_139:
  maskedchar 00 80
__SUCCESS_138:
  closecapture 90
  partialcommit __FOREVER_137
__FORGIVE_136:
__SUCCESS_134:
  closecapture 88
__SUCCESS_133:
  closecapture 87
  ret -- OIDVALUE

  end 0
