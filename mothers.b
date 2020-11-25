/* MOTHERS.B
**
** trail vants give birth in midlife, then die
**
** data[0] - trail color
** data[1] - age
*/

#include "organism.h"
#include "colors.h"

void far main(ORGANISM far *o, LLIST far *list, FUNCT funct[])
{
/***************************/
/* bug behavior code here: */
/***************************/

  int color,i,chillins;

  color = funct[GETPIXEL](1,o->x,o->y);
  if (color==RED)
  {
    funct[PUTPIXEL](1,o->x,o->y,BLUE);
    o->data[0] = RED;
    if (++o->dir > 3) o->dir = 0;
  }
  else if (color==BLUE)
  {
    funct[PUTPIXEL](1,o->x,o->y,RED);
    o->data[0] = BLUE;

    if (--o->dir < 0) o->dir = 3;
  }
  else
    funct[PUTPIXEL](1,o->x,o->y,o->data[0]); /* trails enabled */
  funct[PUTPIXEL](0,o->x,o->y,funct[GETPIXEL](1,o->x,o->y)); /* erase old */

  (o->data[1])++;
  if (!(o->data[1]%50))   /* midlife */
  {
     chillins = funct[RANDOM]()%3+1;
     for(i=0;i<chillins;i++)
       funct[BIRTH](o->strategy,o->buginit,3,o);
  }
  if ((o->data[1]>=95) && (funct[RANDOM]()%100<60)) /* old age death */
  {
/*
       funct[PUTPIXEL](0,o->x,o->y,CYAN);
       funct[PUTPIXEL](1,o->x,o->y,CYAN);
*/
       funct[DEATH](o->id);
       return;
  }

/**************************/
/* code to move bug here: */
/**************************/

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
