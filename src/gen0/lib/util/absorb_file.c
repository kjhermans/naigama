#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>

int absorb_file
  (char* path, unsigned char** buf, unsigned* buflen)
{
  unsigned char tmp[ 1024 ];
  int fd;

  if (0 == strcmp(path, "-")) {
    fd = 0;
  } else if ((fd = open(path, O_RDONLY, 0)) < 0) {
    return -1;
  }
  *buf = malloc(1); (*buf)[0] = 0;
  *buflen = 0;
  while (1) {
    int r = read(fd, tmp, sizeof(tmp));
    if (r <= 0) {
      (*buf)[ *buflen ] = 0;
      return 0;
    } else {
      *buf = (unsigned char*)realloc(*buf, (*buflen) + r + 1);
      memcpy((*buf) + (*buflen), tmp, r);
      (*buflen) += r;
    }
  }
}
