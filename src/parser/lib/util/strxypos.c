/**
 * Counts the number of lines in [string], until [pos] is reached.
 * Calculates the x,y position inside [string], of [pos].
 * Returns the x,y position of a position in a string.
 *
 * \param string  Zero-terminated string, preferably longer than [pos] bytes.
 * \param pos     Position inside the string.
 * \param vector  Contains the line (off-by-one) [0], and position on that
 *                line (off-by-one) [1], on successful return.
 *
 * \returns       Zero on success (pos is inside string), or non-zero on error.
 */
int strxypos
  (char* string, unsigned pos, unsigned vector[ 2 ])
{
  unsigned i = 0;

  vector[ 0 ] = 1;
  vector[ 1 ] = 1;
  while (i < pos) {
    switch (string[ i++ ]) {
    case '\n':
      ++(vector[ 0 ]);
      vector[ 1 ] = 0;
      break;
    case 0:
      return ~0;
    }
    ++(vector[ 1 ]);
  }
  return 0;
}
