# Organism

This is an absolute bit of insanity we wrote back in 1992 in MS-DOS when
we were on an artificial life kick.

Basically we wanted to write organism behavior in C, build it to a bunch
of machine code, load that into the data segment, and jump to it.
Absolutely undefined behavior. Caused crash after crash, once nuking my
BIOS settings.

Great times.

The initialization code for each "bug" is in the `.i` files, and the
main per-iteration instructions are in the `.b` files.

`baptise.btm` is what you'd run to build the bug files to machine code
via assembly.

`.btm` is a batch file for a third-party shell called 4DOS.

This was built with Turbo C.

I have no idea why there's a copy of `autoexec.bat` in here.


```
Archive created: 1992-08-01 01:38:00
Filename       Original Compressed Ratio DateTime modified CRC-32   AttrBTPMGVX
------------ ---------- ---------- ----- ----------------- -------- -----------
COLORS.H            326        174 0.534 92-08-01 00:44:20 479647D1      B 1   
ORGANISM.H          530        289 0.545 92-08-01 00:09:12 28AF6FB6      B 1   
ORGANISM.C         7379       2198 0.298 92-08-01 01:10:30 354EE429      B 1   
AUTOEXEC.BAT        117        101 0.863 92-07-09 22:45:52 85DF9963      B 1   
BAPTISE.BTM        2580        740 0.287 92-08-01 00:48:32 F65C2B72      B 1   
BACKUP.BTM          311        213 0.685 92-07-28 07:24:50 8A7CF32B      B 1   
TEMPLATE.B          669        302 0.451 92-07-28 07:49:46 B9480BCA      B 1   
MOTHERS.B          1610        652 0.405 92-08-01 00:00:34 6E56287F      B 1   
TRAILS.B            890        369 0.415 92-08-01 00:00:28 9BC22BF7      B 1   
VANTS.B             914        377 0.412 92-08-01 00:00:16 E4D51554      B 1   
DUP.B              1137        474 0.417 92-08-01 00:35:50 B00C38BF      B 1   
HUNTER.B           1797        774 0.431 92-08-01 01:31:18 2AE1BD93      B 1   
DUP.I               268        168 0.627 92-07-28 07:28:30 0E2DDA00      B 1   
VANTS.I             340        219 0.644 92-07-28 07:35:12 53EBF478      B 1   
HUNTER.I            863        339 0.393 92-07-29 20:08:32 DB44321A      B 1   
TRAILS.I            388        248 0.639 92-07-28 07:34:12 2F4AD649      B 1   
TEMPLATE.I          290        190 0.655 92-07-26 19:35:34 B3320F8D      B 1   
MOTHERS.I           592        239 0.404 92-07-28 12:50:10 3CFB72AC      B 1   
------------ ---------- ---------- ----- -----------------
    18 files      21001       8066 0.384 92-08-01 01:38:00
```
