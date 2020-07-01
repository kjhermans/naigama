/*
 * This file is part of the Payload Encryptor project.
 * Copyright 2018 Kees-Jan Hermans <kees.jan.hermans@gmail.com>
 * License: Withheld
 */

#include <stdio.h>
#include <ctype.h>

/**
 * Writes the contents of a piece of memory to stderr, hexdump-style.
 */
void logmem
  (void* _mem, unsigned int size)
{
  char* mem = _mem;
  char print[16];
  unsigned int c = 0;
  *print = 0;
  fprintf(stderr, "Debugging memory at %p size %u\n", _mem, size);
  if (size == 0) {
    return;
  }
  fprintf(stderr, "%.8x  ", c);
  while (size--) {
    unsigned char byte = *mem++;
    fprintf(stderr, "%.2x ", byte);
    print[c % 16] = (isprint(byte) ? byte : '.');
    if ((++c % 16) == 0) {
      fprintf(stderr, "     %-.*s\n%.8x  ", 16, print, c);
      *print = 0;
    }
  }
  while (c % 16) {
    print[c % 16] = ' ';
    c++;
    fprintf(stderr, "   ");
  }
  fprintf(stderr, "     %-.*s\n", 16, print);
  fflush(stderr);
}
