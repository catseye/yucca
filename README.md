yucca
=====

Version 1.2 | _Entry_ [@ catseye.tc](https://catseye.tc/node/yucca)
| _See also:_ [hatoucan](https://codeberg.org/catseye/hatoucan#hatoucan)
∘ [Bubble Escape](https://codeberg.org/catseye/Bubble-Escape#bubble-escape)
∘ [Dungeons of Ekileugor](https://codeberg.org/catseye/Dungeons-of-Ekileugor#dungeons-of-ekileugor)
∘ [Apple Befunge](https://codeberg.org/catseye/Apple-Befunge#apple-befunge)

- - - -

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
tokenized BASIC program to a textual form and back.  `yucca` handles
both styles of text file; it can even analyze and manipulate commands in
immediate mode, in the case of the listing being a 'session transcript.'

Case Studies
------------

`yucca` has been successfully used on:

* The editor for [Apple Befunge][] -- `APPLE BEFUNGE EDITOR.bas` is a
  'session transcript' intended to be pasted into an emulator;
* The original version of [Bubble Escape][] -- `bubble escape.bas` is a
  text file detokenized from the original tokenized program;
* [Dungeons of Ekileugor][] -- an original text file, intended to be
  checked and stripped by `yucca`, then passed to a tokenizer such as
  `petcat` or [hatoucan][] to create a loadable VIC-20 BASIC program file.

[Apple Befunge]: http://catseye.tc/node/Apple_Befunge
[Bubble Escape]: http://catseye.tc/node/Bubble_Escape
[Dungeons of Ekileugor]: http://catseye.tc/node/Dungeons_of_Ekileugor
[hatoucan]: http://catseye.tc/node/hatoucan

Usage
-----

    yucca program.bas

Python's `fileinput` module is used, so the BASIC source can also be piped
into `yucca`, and so forth.  Error messages are printed on the standard error
stream.

By default, `yucca` checks that each line number in the program source is
given in strictly ascending order.  Some tokenizers (e.g. `petcat`) will
happily tokenize a program source into a tokenized program with
out-of-sequence and/or duplicate line numbers, and this option prevents
that from happening.  To suppress this check, give the `-A` option on the
command line.

By default, `yucca` checks that the target of each jump in the program is an
existing line number.  This includes any jumps that may occur in immediate
mode commands (i.e. commands with no line number) given in the text
file.  If this check fails, further transformations may not be performed on
the program.  To suppress this check, pass the `-L` option to `yucca`.

`yucca` cannot analyze the validity of any computed line number in a BASIC
program which contains computed `GOTO`s or `GOSUB`s.  To reduce the chance
of an computed line number going unnoticed and unanalyzed, `yucca`'s
default behavior is to report an error if it finds any computed `GOTO`s
or `GOSUB`s in the input program.  To acknowledge that you are aware that
the program contains computed jumps that `yucca` will not be able to
analyze, pass the `-C` option to have `yucca` suppress these errors.

The `-o` option may be given to dump a copy of the program to the standard
output.  This option is implied by the following two options.

The `-I` option strips all immediate mode commands from the program before
analyzing and outputting it.

The `-R` option strips all remarks (`REM` statements) from the program
before analyzing and outputting it.  Note that this happens before
analysis, so that any jumps to lines which contain only a `REM` will be
found and reported.

The `-p` option causes all program transformations to act only on program
lines, not on immediate mode lines.  Thus, in combination with `-R`, `REM`s
on immediate mode lines are not removed.  It does not affect `-I` at all.

The `-x` option allows symbol constants to be defined in, and expanded in,
a yucca source.  A symbolic constant is any alphanumeric token inside
square bracket.  A symbolic constant is defined by placing it as the first
thing on a line, followed immediately by an equals sign, followed immediately
by the value it represents.  Such lines will be stripped, and the values for
those constants expanded in other lines, when `-x` is given.

The `-t` option runs `yucca` through its internal test suite and exits
immediately.

Plans
-----

`yucca` could be easily extended to warn about "code smells" such as a 
redundant `GOTO` to the next line, a `GOTO` to a line containing only
another `GOTO`, and so forth.

`yucca` can dump the input program with (as far as I can tell) total
fidelity; it retains case and spacing of all lines, even leading and
trailing whitespace.

This facility could be built upon to give `yucca` the ability to
renumber a program, or to supply missing line numbers, or even transform
a program with textual labels into one with line numbers.
