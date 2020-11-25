#include "organism.h"
#include "colors.h"

void far main(ORGANISM far *o, ORGANISM far *parent, FUNCT funct[])
{
  if (parent == NULL)
  {
    o->x = funct[RANDOM]()%MAXX;
    o->y = funct[RANDOM]()%MAXY;
    o->color = WHITE;
    o->dir = funct[RANDOM]()%4;
    o->data[0] = funct[RANDOM]()%2?RED:BLUE;  /* trail color */
    o->data[1] = 0;  /* age */
  }
  else
  {
    o->x = parent->x;
    o->y = parent->y;
    o->color = GREEN;
    o->dir = funct[RANDOM]()%4;
    o->data[0] = funct[RANDOM]()%2?RED:BLUE;  /* trail color */
    o->data[1] = 0;  /* age */
  }
}
