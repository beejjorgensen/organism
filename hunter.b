/* HUNTER.B
**
** seeks out the closest bug and kills it
**
** data[0] - maximum vision distance in any direction
*/

#include "organism.h"
#include "colors.h"

#define ABS(x) ((x)<0?-(x):(x))

void far main(ORGANISM far *o, LLIST far *list, FUNCT funct[])
{
  LLIST far *other,far *p,far *t=NULL;
  int d,bd=9999;

  p = list;

  while(p != NULL)
  {
    if ((p->bug.type != o->type) || (o->data[3] <= 20))
        /* don't hunt each other */
    {
     if (ABS(p->bug.x - o->x)<o->data[0] && ABS(p->bug.y - o->y)<o->data[0]) /* and in vision range */
      if ((d=funct[DIST](p->bug.x,p->bug.y,o->x,o->y)) < bd) /* and closest */
      {
          bd = d;
          t = p;
      }
    }
    else /* found one of it's own kind */
    {
    }
    p = p->next;
  }

  if (bd<=2)
  {
    funct[PUTPIXEL](0,t->bug.x,t->bug.y,funct[GETPIXEL](1,t->bug.x,t->bug.y)); /* erase old vant */
    funct[DEATH](t->bug.id);
    o->data[3] += 100;
    if (o->data[3] > 32000) o->data[3] = 32000;
  }

  if (o->data[3] >= 600)
  {
    funct[BIRTH](o->strategy,o->buginit,4,o);
    o->data[3] -= 300;
  }
  o->data[3]--;  /* more hunger! */

  funct[PUTPIXEL](0,o->x,o->y,funct[GETPIXEL](1,o->x,o->y)); /* erase old vant */

  if (t != NULL)  /* home in */
  {
    if (t->bug.x >o->x) o->x+=2;
    if (t->bug.x <o->x) o->x-=2;
    if (t->bug.y >o->y) o->y+=2;
    if (t->bug.y <o->y) o->y-=2;
  }
  else
  {
    o->x += o->data[1];
    o->y += o->data[2];
  }

  if (o->x >= MAXX) o->x = 0;
  if (o->x < 0) o->x = MAXX-1;
  if (o->y >= MAXY) o->y = 0;
  if (o->y < 0) o->y = MAXY-1;

  if (o->data[3] < 0)  /* death alert! */
  {
    funct[DEATH](o->id);
    return;
  }
  funct[PUTPIXEL](0, o->x, o->y, YELLOW); /* put new vant */
}
