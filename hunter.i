#include "organism.h"
#include "colors.h"

void far main(ORGANISM far *o, ORGANISM far *parent, FUNCT funct[])
{
 if (parent == NULL)
 {
  o->x = funct[RANDOM]()%MAXX;
  o->y = funct[RANDOM]()%MAXY;
  o->color = YELLOW;
  o->data[0] = 25;  /* distance the bug can "see" */
  o->data[1] = 2*(funct[RANDOM]()%3-1);  /* dx */
  o->data[2] = 2*(funct[RANDOM]()%3-1);  /* dy */
  o->data[3] = 200; /* hunger level */
  o->data[4] = 0;   /* number of bugs terminated (with extreme predjudice) */
 }
 else
 {
  o->x = parent->x;
  o->y = parent->y;
  o->color = YELLOW;
  o->data[0] = parent->data[0]+(funct[RANDOM]()%11-5);/* distance the kid can "see" */
  o->data[1] = 2*(funct[RANDOM]()%3-1);  /* dx */
  o->data[2] = 2*(funct[RANDOM]()%3-1);  /* dy */
  o->data[3] = 200; /* hunger level */
  o->data[4] = 0;   /* murder count */
 }
}

