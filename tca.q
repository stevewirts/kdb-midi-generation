//see algorithm.txt for a details description
//of the algorithm implemented here 

\l midi.q

perpetual:1b;
numtriads:8;
range:60 84;
startnote:enlist "j"$first med range; //62 + til 22;
steps:1 -1;

filter:{not[perpetual]|first(all{in[;steps]last deltas 1 -1#\:x}x)&all x within range}

triads:(!). flip (
 (`major;4 3);
 (`minor;3 4);
 (`diminished;3 3);
 (`augmented;4 4);
 (`sus;5 5);
 (`onefour;1 4);
 (`onesix;1 6)
 );

ladder:{(0;x 1;12-x 0;12;12+x 1)}
k) prm:{x{,/(>:'t=/:t:*x)@\:x:0,'1+x}/,!0} // permutations
//ilsi:raze(0 1 2;1 2 3;2 3 4)@\:(0 1 2;0 2 1;1 0 2;1 2 0;2 1 0;2 0 1) // inversion ladder sequence indexes
ilsi:raze til[3]+\:prm 3; // inversion ladder sequence indexes
generateline:{sums first[1?startnote],1 _ raze flip (enlist numtriads?1 -1),flip neg[numtriads] ? {1_ deltas x} each ladder[triads x]@ilsi}
generatelines:{
 lines:generateline each (y*200)#x;
 lines:y#lines where filter each lines;
 lines}

saveline:{(`$raze ":lines/",string[x],"/",string[x],string[y 0],".mid") 1: .midi.midi y 1};

savelines:{
 lines:generatelines[x;y];
 saveline[x;] each flip (til count lines; lines)}

generateall:{
    savelines[;x] each key triads
 }
