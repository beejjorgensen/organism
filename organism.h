#define MAXX 640
#define MAXY 350
#define MAXMEM 16
#define MAXBUG 10
#define NUMSUB_FUNCT 6
#define PUTPIXEL 0
#define GETPIXEL 1
#define RANDOM 2
#define BIRTH 3
#define DEATH 4
#define DIST 5

/*********** types ***********/

typedef int (far *FUNCT)();

typedef struct organism
{
  int x,y,dir,color,id,type; /* dir: 0 - north, 1 - east, 2 - south, 3 - west */
  short data[MAXMEM];
  FUNCT strategy,buginit;
}
ORGANISM;

typedef struct llist
{
  ORGANISM bug;
  struct llist far *next;
}
LLIST;
