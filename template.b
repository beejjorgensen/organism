#include "organism.h"
#include "colors.h"

void far main(ORGANISM far *o, LLIST *list, FUNCT funct[])
{
/***************************/
/* bug behavior code here: */
/***************************/



/**************************/
/* code to move bug here: */
/**************************/
  funct[PUTPIXEL](0,o->x,o->y,funct[GETPIXEL](1,o->x,o->y)); /* erase old */
  if (o->dir==0) o->y--;
  else if (o->dir==1) o->x++;
  else if (o->dir==2) o->y++;
  else o->x--;
  if (o->x >= MAXX) o->x = 0;
  if (o->x < 0) o->x = MAXX-1;
  if (o->y >= MAXY) o->y = 0;
  if (o->y < 0) o->y = MAXY-1;
  funct[PUTPIXEL](0, o->x, o->y, WHITE); /* put new bug */
}
