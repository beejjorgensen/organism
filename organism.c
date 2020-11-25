/************************************************************
*                        organisms                          *
*                                                           *
* compile using medium memory model, link to "graphics.lib" *
************************************************************/

#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <graphics.h>
#include <time.h>
#include <alloc.h>
#include <dos.h>
#include <math.h>
#include "organism.h"

#define SQR(x) ((x)*(x))
#define ABS(x) ((x)<0?-(x):(x))

/************ function prototypes *************/

FUNCT loadDYNAMO(char *);
void createbugs(FUNCT bugstrategy[], FUNCT buginitfunct[]);
void initscreen(int background);
int far printinfo(ORGANISM far *o);
int far getpixelon(int page, int x, int y);
int far  putpixelon(int page, int x, int y, int c);
int llappend(FUNCT strat, FUNCT initfunct, int type, ORGANISM far *o);
int lldelete(int id);
int far randwrap(void);
int far birth(FUNCT strat, FUNCT initfunct, int type, ORGANISM far *o);
int far death(int id);
int far dist(int x1, int y1, int x2, int y2);

/************ global vars ****************/

LLIST far *head=NULL,far *tail=NULL;
FUNCT sub_funct[NUMSUB_FUNCT+1];

/************ main() **************/

main()
{
  LLIST far *p,far *t;
  char c=0;
  FILE *fp;
  FUNCT bugstrategy[MAXBUG],buginitfunct[MAXBUG];
  short count=0;

  sub_funct[PUTPIXEL] = putpixelon;
  sub_funct[GETPIXEL] = getpixelon;
  sub_funct[RANDOM] = randwrap;
  sub_funct[BIRTH] = birth;
  sub_funct[DEATH] = death;
  sub_funct[DIST] = dist;
  sub_funct[NUMSUB_FUNCT] = printinfo;

  randomize();

  bugstrategy[0]  = loadDYNAMO("vants.bug");
  buginitfunct[0] = loadDYNAMO("vants.ini");

  bugstrategy[1]  = loadDYNAMO("trails.bug");
  buginitfunct[1] = loadDYNAMO("trails.ini");

  bugstrategy[2]  = loadDYNAMO("dup.bug");
  buginitfunct[2] = loadDYNAMO("dup.ini");

  bugstrategy[3]  = loadDYNAMO("mothers.bug");
  buginitfunct[3] = loadDYNAMO("mothers.ini");

  bugstrategy[4]  = loadDYNAMO("hunter.bug");
  buginitfunct[4] = loadDYNAMO("hunter.ini");


  createbugs(bugstrategy,buginitfunct);
  initscreen(1);

  do
  {
    p = head;


/*  gotoxy(1,1);printf("%u %d  ",coreleft(),count);*/    /* watch memory */

    count = 0;

    while(p != NULL)
    {

      (p->bug.strategy)(&(p->bug), head, sub_funct); /* maybe cast here */
      p = p->next;count++;
    }
    if (kbhit()) c = tolower(getch());


    if (c=='k')
    {
       p = head;
       while(p!=NULL)
       {
         putpixelon(0,p->bug.x,p->bug.y,getpixelon(1,p->bug.x,p->bug.y));
         t=p->next;
         farfree(p);
         p = t;
       }
       p = head = tail = NULL;
       c = 0;
    }

    if (c=='l')
    {
      createbugs(bugstrategy,buginitfunct);
      c = 0;
    }

    if (c == 'c')
    {
      initscreen(1);
      c = 0;
    }


  }
  while(c != 27);
  closegraph();
}

/*********** printinfo() ***********/

int far printinfo(ORGANISM far *o)
{
    printf("x = %d, y = %d, c = %d, d = %d, id = %d, type = %d\n", o->x,o->y,o->color,o->dir,o->id,o->type);
}
/*********** loadDYNAMO() ************/

FUNCT loadDYNAMO(char *fn)
{
    char far *xx_str;
/*    char *x_str;*/
    FILE *in;
    long length;

    in = fopen(fn, "rb");
    if (in==NULL)
    {
	printf("Couldn't open %s, Omot.",fn);
	return NULL;
    }

    length = filelength(fileno(in));
    if (length == -1L)
    {
	puts("Couldn't get filelength (??)");
	return NULL;
    }

    xx_str = (char far *)malloc((size_t)length);
    if (xx_str == NULL)
    {
    printf("Couldn't farmalloc %d bytes, bummer.\n",(size_t)length);
	return NULL;
    }

    if (fread((void far *)xx_str, (size_t)length, 1, in)==0)
    {
	printf("Bogosity error reading %s, Omot.",fn);
	return NULL;
    }

/*    xx_str = (char far *) MK_FP(_DS, x_str);*/

    fclose(in);

    return (FUNCT)xx_str;
}

/*********** createbugs() ***********/

void createbugs(FUNCT bugstrategy[], FUNCT buginitfunct[])
{
  int i;

  for(i=0;i<=5;i++)
  {
/*  llappend(bugstrategy[0],buginitfunct[0],0, NULL);*/  /* vants */
/*  llappend(bugstrategy[1],buginitfunct[1],1, NULL);*/  /* vants w/ trails */
/*  llappend(bugstrategy[2],buginitfunct[2],2, NULL);/* /* duplicates */
    llappend(bugstrategy[3],buginitfunct[3],3, NULL);  /* mothers */
    llappend(bugstrategy[3],buginitfunct[3],3, NULL);  /* mothers */
    llappend(bugstrategy[4],buginitfunct[4],4, NULL);  /* hunter */
  }
}

/*********** llappend() ************/

int llappend(FUNCT strat, FUNCT initfunct, int type, ORGANISM far *o)
{
  LLIST far *temp;

  static unsigned short id;

  temp = (LLIST far *)farmalloc(sizeof(LLIST));
  if (temp == NULL)
  {
    fprintf(stderr, "Error farmallocing space for creature, Omot.\n");
    getche();
    return -1;
  }

  (initfunct)(&(temp->bug), o, sub_funct); /* maybe cast here */

  temp->bug.id = id++;
  temp->bug.strategy = strat;
  temp->bug.buginit = initfunct;
  temp->bug.type = type;

  if (head==NULL)
  {
    head = tail = temp;
    head->next = NULL;
  }
  else
  {
    tail->next = temp;
    tail = tail->next;
  }
  tail->next = NULL;

  return id-1;
}

/********** lldelete() ************/

int lldelete(int id)
{
    LLIST far *p, far *prev;

    p = prev = head;

    if (head == NULL) return;  /* this should never happen */

    while(p != NULL)
    {
        if (p->bug.id == id)
        {
            if (p == head)
            {
              if (head == tail) tail = NULL;
              head = head->next;
            }
            else
            {
              prev->next = p->next;
              if (p == tail) tail = prev;
            }
            farfree(p);
            return;
        }
        prev = p;
        p = p->next;
    }
}


/********** initscreen() **********/

void initscreen(int b)
{
  int gm=EGAHI,gd=EGA,i,j,x,y,c;

  initgraph(&gd,&gm,"c:\\lang\\tc\\bgi");
  switch(b)
  {
    case 1: for(j=1;j<3000;j++)
	    {
	      setactivepage(1);
	      putpixel(x=rand()%MAXX,y=rand()%MAXY,c=rand()%2?RED:BLUE);
	      setactivepage(0);
	      putpixel(x,y,c);
	    }
	    break;
    case 2: setactivepage(1);
	    setfillstyle(SOLID_FILL,BLUE);
	    floodfill(0,0,WHITE);
	    setactivepage(0);
	    floodfill(0,0,WHITE);
	    break;
  }
}

/*********** getpixelon() ***********/

int far getpixelon(int page, int x, int y)
{
  int c;

  setactivepage(page);
  c = getpixel(x,y);
  setactivepage(!page);

  return c;
}

/*********** putpixelon() ***********/

int far putpixelon(int page, int x, int y, int c)
{
  setactivepage(page);
  putpixel(x,y,c);
  setactivepage(!page);
}

/************* randwrap() ***********/

int far randwrap(void)
{
    return (int)rand();
}

/************* birth() ************/

int far birth(FUNCT strat, FUNCT initfunct, int type, ORGANISM far *o)
{
    return llappend(strat, initfunct, type, o);
}

/************* death() ************/

int far death(int id)
{
    return lldelete(id);
}

/************** dist() ***********/

int far dist(int x1, int y1, int x2, int y2)
{
    return ABS(x1-x2)+ABS(y1-y2);
}
