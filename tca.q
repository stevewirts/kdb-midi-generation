\l midi.q
start:64;
steps:-1 1;
minmax:59 89;
seq:(0 1 2;0 2 1;1 0 2;1 2 0;2 0 1;2 1 0);
invr:(til 3;1 + til 3;2 + til 3)
combs:raze {x seq} each invr;
nts:{(0;x 1;12-x 0;12;12+x 1)}
compdifs:{(0;x[1]-x[0];x[2]-x[1])}
major:4 3;
minor:3 4;
diminished:3 3;
augment:4 4;

triads:{compdifs each (nts x) combs};
step:{fx:flip x;flip ((count x)?steps;fx 1; fx 2)};
filter:{x where { ((min x)>minmax 0)&((max x) < minmax 1) } each x};
generateline:{start + (+\) raze step 8?triads x};
generatelines:{
 lines:();
 do[y*20;lines,:enlist generateline x];
 r:y # filter lines;
 r};

saveline:{
    (`$raze ":lines/",(string x),"_",(string y 0),".mid") 1: midi y 1};

savelines:{
 lines:generatelines[x;y];
 saveline[x;] each flip (til count lines; lines)}


\e 1

/go[`major]

/
go[`minor] each til 10
go[`diminished] each til 10