/* DUP.B
**
** gives birth every 50 cycles
**
** data[0] - age
*/

#include "organism.h"
#include "colors.h"

void far main(ORGANISM far *o, LLIST far *list, FUNCT funct[])
{
  int color;

/***************************/
/* bug behavior code here: */
/***************************/

  color = funct[GETPIXEL](1,o->x,o->y);
  if (color==RED)
  {
    funct[PUTPIXEL](1,o->x,o->y,BLUE);
    if (++o->dir > 3) o->dir = 0;
  }
  if (color==BLUE)
  {
    funct[PUTPIXEL](1,o->x,o->y,RED);
    if (--o->dir < 0) o->dir = 3;
  }

  o->data[0]++;
  if (o->data[0] == 5)
  {
     funct[BIRTH](o->strategy,o->buginit,o->type);
     o->data[0] = 0;
  }

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
