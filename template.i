#include "organism.h"
#include "colors.h"

void far main(ORGANISM far *o, ORGANISM far *parent, FUNCT funct[])
{
  o->x = funct[RANDOM]()%MAXX;
  o->y = funct[RANDOM]()%MAXY;
  o->color = WHITE;
  o->dir = funct[RANDOM]()%4;
  o->data[0] = 0;  /* up to MAXMEM in this array */
}
