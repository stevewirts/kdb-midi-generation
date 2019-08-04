// see http://midi.teragonaudio.com/tech/midifile.htm
// simple midi generation of 8th note streams
// the midi function takes a vector of integers
// that should be between 0 (low C) and 128

\d .midi

bpm:120;
ppq:96;
Mthd:0x4d546864;
MTrk:0x4d54726b;
endoftrack:0xff2f00;
spacer:0x00;
deltatime:0x00c001;
timesignature:0xff580404021808;
keysignature:0xff59020000; //c major
tempo:{0xff5103,-3#0x0 vs floor 60000000%x}bpm;

eighthnote:{0x90,"x"$x,0x3630,0x90,"x"$x,0x0000};
// Mthd,length (6), formattype(1), numberof tracks(1), 96ppq
simpleheader:Mthd,0x00000006,0x0001,0x0001,-2#0x0 vs ppq;

notes:{
 raze deltatime,
 spacer,
 keysignature,
 spacer,
 timesignature,
 spacer,
 tempo,
 spacer,
 (eighthnote each x),
 endoftrack}

midi:{
    body: notes x;
    raze simpleheader,MTrk,(0x0 vs "i"$count body),body}

\d .
/

/ 6 notes ascending chromatically from middle c
`:line.mid 1: midi 72+ 0 1 2 3 4 5;

/ 10 random 16 note rows
{(`$raze "line_",string x,".mid") 1: midi 63 + -16 ? 16} each til 10
