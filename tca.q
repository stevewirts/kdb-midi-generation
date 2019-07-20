\l midi.q
seq:(0 1 2;0 2 1;1 0 2;1 2 0;2 0 1;2 1 0);
invr:(til 3;1 + til 3;2 + til 3)
nts:{(0;x 1;12-x 0;12;12+x 1)}
compdifs:{(0;x[1]-x[0];x[2]-x[1])}
steps:-1 1;
major:4 3;
minor:3 4;
diminished:3 6;

triads:{compdifs each (nts x)raze {x seq} each invr};
step:{fx:flip x;flip ((count x)?steps;fx 1; fx 2)}
go:{(`$raze ":",(string x),"_",string y,".mid") 1: midi 64 + (+\) raze step 8?triads x};
/
go[`major] each til 10
go[`minor] each til 10
go[`diminished] each til 10