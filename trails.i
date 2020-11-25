/* bug initializer file bug 1 (leaves trails like a woman with no legs) */

#include "organism.h"
#include "colors.h"

void far main(ORGANISM far *o, ORGANISM far *parent, FUNCT funct[])
{
  o->x = funct[RANDOM]()%MAXX;
  o->y = funct[RANDOM]()%MAXY;
  o->color = WHITE;
  o->dir = funct[RANDOM]()%4;
  o->id = '!';
  o->data[0] = RED;   /* doesn't matter for this bug */
}
