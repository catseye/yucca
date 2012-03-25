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

Case Studies
------------

`yucca` has been successfully used on:

* The editor for [Apple Befunge][]
* The original version of [Bubble Escape][].

[Apple Befunge]: http://catseye.tc/projects/apple-befunge/
[Bubble Escape]: http://bitbucket.org/catseye/bubble-escape/

Usage
-----

(subject to change)

    yucca program.bas

Python's `fileinput` module is used, so the BASIC source can also be piped
into `yucca`, and so forth.

By default, the program is checked that the target of each jump is an
existing line number.  This includes any jumps that may occur in immediate
mode commands (i.e. commands with no line number) given in the text
file.  If this check fails, further transformations may not be performed on
the program.  To suppress this check, pass the -L option to `yucca`.

The -o option may be given to dump a copy of the program to the standard
output.  This option is implied by several other options.

The -I option strips all immediate mode commands from the program before
analyzing and outputting it.

The -t option runs `yucca` through its internal test suite and exits
immediately.

TODO
----

* Retain whitespace exactly when dumping/transforming a program.
* Better reporting for errors discovered in immediate mode commands.

Plans
-----

`yucca` could be easily extended to warn about "code smells" such as a 
redundant `GOTO` to the next line, `GOTO` to a `REM` line, and so forth.

`yucca` can dump the input program with high fidelity; the only things that
it will change are the case of commands such as `GOTO` and `GOSUB`, and
whitespace in certain places, including around line numbers in an
`ON ... GOTO` or `ON ... GOSUB`.  This facility could be built upon to give
`yucca` the ability to renumber a program, or to supply missing line
numbers, or even transform a program with textual labels into one with line
numbers.
