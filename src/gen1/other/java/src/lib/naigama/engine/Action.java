package lib.naigama.engine;

class Action
{
  static final int TYPE_CAPTURE_OPEN = 1;
  static final int TYPE_CAPTURE_CLOSE = 2;
  static final int TYPE_REPLACE_CHAR = 3;
  static final int TYPE_REPLACE_QUAD = 4;

  int type;
  int slot;
  int offset;
}
