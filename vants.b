#include "organism.h"
#include "colors.h"

void far main(ORGANISM far *o, LLIST far *list, FUNCT funct[]) /* vants */
{
  int color;

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
  funct[PUTPIXEL](0,o->x,o->y,funct[GETPIXEL](1,o->x,o->y)); /* erase old vant */

/*  switch(o->dir)
  {
    case 0: o->y--;break;
    case 1: o->x++;break;
    case 2: o->y++;break;
    case 3: o->x--;break;
  }*/
  if (o->dir==0) o->y--;
  else if (o->dir==1) o->x++;
  else if (o->dir==2) o->y++;
  else o->x--;

  if (o->x >= MAXX) o->x = 0;
  if (o->x < 0) o->x = MAXX-1;
  if (o->y >= MAXY) o->y = 0;
  if (o->y < 0) o->y = MAXY-1;
  funct[PUTPIXEL](0, o->x, o->y, o->color); /* put new vant */
}
