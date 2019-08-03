# kdb-midi-generation
simple q script for generating midi files containing streams of eight notes 
----
### 6 notes ascending chromatically from middle c
```
`:line.mid 1: midi 72+ 0 1 2 3 4 5;
```
----
### 2 octaves ascending then descending chromatic scale starting on low c
```
`chromatic.mid 1: midi 60 + (til 24),reverse til 25
```
----
### 10 random 16 note rows
```
{(`$raze "line_",string x,".mid") 1: midi 63 + -16 ? 16} each til 10
```
