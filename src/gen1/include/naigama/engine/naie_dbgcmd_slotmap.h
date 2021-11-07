#ifndef _SLOTMAP_DEBUGCOMMAND_H_
#define _SLOTMAP_DEBUGCOMMAND_H_

/* Generated by genslthdr in ./grammar/debugcmd.slotmap */

#define SLOT_CMD 8
#define SLOT_CMD_1 9
#define SLOT_CMD_AZ 11
#define SLOT_CMD_AZAZAZAZ 13
#define SLOT_CMD_CONTC 2
#define SLOT_CMD_HELPH 4
#define SLOT_CMD_INPUTSOFFSETSTEXTS 7
#define SLOT_CMD_INSTRSAZ 10
#define SLOT_CMD_LABELSAZAZAZAZ 12
#define SLOT_CMD_NEXTN 0
#define SLOT_CMD_OVERO 3
#define SLOT_CMD_QUITQ 1
#define SLOT_CMD_STATE 6
#define SLOT_CMD_VERBOSEV 5

#define _SLOTMAP_DEBUGCOMMAND_SWITCH \
  case 8: return "SLOT_CMD"; break; \
  case 9: return "SLOT_CMD_1"; break; \
  case 11: return "SLOT_CMD_AZ"; break; \
  case 13: return "SLOT_CMD_AZAZAZAZ"; break; \
  case 2: return "SLOT_CMD_CONTC"; break; \
  case 4: return "SLOT_CMD_HELPH"; break; \
  case 7: return "SLOT_CMD_INPUTSOFFSETSTEXTS"; break; \
  case 10: return "SLOT_CMD_INSTRSAZ"; break; \
  case 12: return "SLOT_CMD_LABELSAZAZAZAZ"; break; \
  case 0: return "SLOT_CMD_NEXTN"; break; \
  case 3: return "SLOT_CMD_OVERO"; break; \
  case 1: return "SLOT_CMD_QUITQ"; break; \
  case 6: return "SLOT_CMD_STATE"; break; \
  case 5: return "SLOT_CMD_VERBOSEV"; break; \


#endif
