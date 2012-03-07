yucca
=====

IT SO HAPPENS in the course of human events that one may find oneself 
cross-developing an 8-bit BASIC program from a modern development 
environment.

IN THESE CASES it behoves one to take advantage of the aforementioned 
modern development environment to increase one's confidence that the 
cross-developed code is correct.

IT IS FOR THIS PURPOSE that _yucca_ was developed.  It is a small Python 
program which can perform static analysis on 8-bit BASIC programs.  
Specifically, it can, at present, check that every line number which is 
a target of a jump is actually present in the program.  If it is not, an 
error message describing the inconsistency is given.

WITH GENERAL APPLICABILITY in mind, yucca recognizes the common forms of 
jumps available in BASIC (`GOTO`, `GOSUB`, `ON ... GOTO`, `ON ... 
GOSUB`, `IF ... GOTO`, and `IF ... THEN` followed by a line number)
while ignoring any constructs it does not understand.  This allows it to
be dialect-agnostic, with the unavoidable limitation that it cannot 
recognize (and thus will not check) computed `GOTO`s or any 
dialect-specific command that involves line numbers.

THE BASIC PROGRAM to be analyzed must be present in a textual form.  
Some emulators allow such text to be pasted in, to simulate entering it 
at the 8-bit computer's keyboard; other tools are available to convert a 
tokenized BASIC program to a textual form and back.

Usage
-----

(subject to change)

    yucca -l program.bas

TODO
----

* Parse `REM` lines more accurately (they may contain colons.)
* Retain whitespace exactly when dumping/transforming a program.

Plans
-----

yucca could be easily extended to warn about "code smells" such as a 
redundant `GOTO` to the next line, `GOTO` to a `REM` line, and so forth.

yucca can dump the input program with almost total fidelity; the only 
thing that it will change (I think) is the whitespace around lines 
numbers in an `ON ... GOTO` or `ON ... GOSUB`.  This could be built upon 
to give yucca the ability to renumber a program, or to supply 
missing line numbers, or even transform a program with textual labels 
into one with line numbers.

