// this is the script that has more
// knowledge about things music
// specifically the logic to generate
// lines based on george garzones
// triadic chromatic approach
// http://www.georgegarzone.com/index1.html
\l midi.q
perpetual:1b;
numtriads:8;
range:60 82;
starts:enlist "j"$first med range; //62 + til 22;
steps:1 -1;
seq:(0 1 2;0 2 1;1 0 2;1 2 0;2 0 1;2 1 0);
invr:(til 3;1 + til 3;2 + til 3)
combs:raze {x seq} each invr;
nts:{(0;x 1;12-x 0;12;12+x 1)}
compdifs:{(0;x[1]-x[0];x[2]-x[1])}
i:.[!;flip(             //intervals
    (`halfstep;1);
    (`wholestep;2);
    (`minor3rd;3);
    (`major3rd;4);
    (`fourth;5);
    (`tritone;6))];
major:i`major3rd`minor3rd;
minor:i`minor3rd`major3rd;
diminished:i`minor3rd`minor3rd;
augment:i`major3rd`major3rd;
suspend:i`fourth`fourth;
trisus:i`fourth`tritone;
chrotri:i`halfstep`tritone;
chrosus:i`halfstep`major3rd;
stepsus:i`wholestep`major3rd;
tristep:i`wholestep`tritone;

triads:{compdifs each (nts x) combs};
step:{fx:flip x;flip ((count x)?steps;fx 1; fx 2)};
filter:{x where { ((min x)>range 0)&((max x) < range 1)&((first ((1#x)-(-1#x)) in steps)|not perpetual) } each x};

generateline:{
 start:first 1?starts;
 line:(+\) raze step?[neg numtriads]triads x;
 line[0]:0;
 start + line};

generatelines:{
 lines:generateline each #[min (100000;y*1000)]x;
 filtered:filter lines;
 $[count filtered;;-1"unsolvable, change number of triads or turn off perpetual";:()];
 neg[y] ? filtered};

saveline:{
 (`$raze ":lines/",string[x],"/",string[x],string[y 0],".mid") 1: midi y 1};
 //(`$raze ":/Users/swirts/Desktop/tca-kdb talk/lines/",string[x],string[y 0],".mid") 1: midi y 1};

savelines:{
 lines:generatelines[x;y];
 saveline[x;] each flip (til count lines; lines)}


/
savelines[`major;3]
savelines[`minor;3]
savelines[`diminished;3]

perpetual:0b;
savelines[`augment;3]

/
`:triads.mid 1: midi 72 + (+\) raze triads`major

n:(72 + (+\) raze {0 0,x[1 2]}each triads`major)
q)n[4* til 18]:60
`:triads.mid 1: midi n
`:range.mid 1: midi range;
