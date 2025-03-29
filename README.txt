Hiatus:
------

29 March 2025: I had hoped to be finished with this in February and
   it's almost April. I am putting this on hiatus so I can work
   through another text.

1. Updates for Racket lag, but they really boil down to changing the
   reference to SRFI-78 and adding #lang simply_scheme. 

2. I +may+ want to try this in scheme48, or at least do enough to
   determine if this could be done in scheme48.

3. Consistency in using SRFI-78 'check' could be better.

4. Problems 20.8 and 20.9 involve fleshing out the tic-tac-toe
   program. I haven't done that yet and I'm not really motivated to
   get it done.

5. Problem 23.15 (n-dimensional matrix via vectors) isn't done yet.
   The two-dimensional matrix in 23.14 is done.

6. Chapters 24 and 25 involve a spreadsheet program. I've done a bit
   more than half of the assignments. Enough to convince myself I know
   what's going on.

7. Chapter 26 proposs a project to create a database program. It
   reminds me of DB IV. Some types are provided but the program has to
   be started from scratch. As I have some other project sized work
   that I plan to use Scheme with, and I have history supporting
   databae internals in the 80s and 90s, I'm comfortable leaving
   undone. I wouldn't mind doing it, but I've spent more time in this
   text than I alotted.

If anyone is still looking at the text, feel free to have at what's
done here. If you spot an error, have something to contribute, or have
a question, drop an issue on Github.

Happy Schemes!

                          ============================
                           Working Through the Text:
                                 Simply Scheme:
                          Introducing Computer Science
                                      2/e
                             Copyright (C) 1999 MIT
                          ============================

These directories hold my worked problems and some supporting files
for the textbook:

Harvey, B., & Wright, M. (1999).
Simply Scheme: Introducing Computer Science (2ND ed.). MIT.
(https://people.eecs.berkeley.edu/~bh/ss-toc2.html)

...as downloaded mid January 2025.

To work through the text in 2025 you need to do one of the following:

- Load `From_Text/simply.scm' into your Scheme (Chicken 5 tested, R5RS
  seems to be required, does not work with current Guile or Chez).

- Use Racket with it's `#lang simply-scheme' directive.


Files from the Text:
-------------------

These can all be found in 'From_Text\'. The authors provide a common
abstraction layer in 'simply.scm' and it must be loaded (or emulated
in Racket). The other files are demonstrations and examples from the
text. 


Tooling Choices:
---------------

I started out using Chicken Scheme and Emacs/Geiser but quite frankly
the Scheme support in Emacs for anything but Guile is lacking. Out of
frustration I turned to Racket and while I don't like the immutable
bindings of a run when I'm debugging, it is a better experience than
Geiser or traditional `inferior scheme' support.

But Racket's IDE is both heavier tooling than I want, and it's editor
support is not all that good. But there are times where the debugger
is welcome.

I've settled on Neovim with (as yet) no LSP for working with Chicken.
Depending on the problem I may want a debugger and Racket.

I do all the problems for a chapter in either Racket or Chicken, copy
the working result to the other, update the preamble (#lang for
Racket, and load/import for Chciken), and retest. It's a lot of work I
don't need, but if someone wants to try any of these out they aren't
forced to edit or switch their tooling to get started.


Additional Requirements:
-----------------------

I rely on srfi-78 for testing. It's a minimal framework and I like to
have many small tests. Just enough testing! There is no required setup
beyond loading it:

- For Chicken: (import srfi-78)

- For Racket: (require srfi/78)

Needed around chapter 13, but useful before then, is a runtime trace
facility. One is available in Racket with simply-scheme enabled, but
in Chicken you must '(import trace)'.


The Worked Problems:
-------------------

My worked problems are in 'Problems_[Chicken|Racket]\'. I use distinct
file extensions (.scm or .rkt) so the directories could be merged, but
that would be more than a bit ugly.

The file names for the problem sets follow this pattern:

ch##--bb-ee.[rkt/scm]

Where:

  ## is the chapter number
  bb is the first (or only) problem in the file
  ee is the last problem in the file

Larger project sized work from the text is named:

ch##--name.scm

All the files contain the following as preamble and epilog:

  - Comments appropriate to the problems.
  - Racket:
      - #lang simply-scheme
      - (require srfi/78)
  - Chicken:
      - (load "required.scm") which grabs simply.scm
      - (import srfi-78)
      - (import trace)
  - Optional and minimal setup for srfi-78 reporting.

When I started this project in Chicken I had envisioned executing all
worked problems and their tests in batch mode, with the pass/fail from
the tests providing assurance that everything works. This may or may
not be possible or worth doing in Racket, but the problem files are
still written to support doing so.

My normal approach is to have a scratch file open and let it grow. As
I started working problems from texts, I tried to write the files so
that code from them could be easily used (or copied). This led to
quasi-literate programming style comments interspered with code and
data.

For a language with a repl (Scheme, Ruby, Python) I make an effort to
keep the file clean enough to load completely.

For this text, I quickly determined that one file per chapter problem
set was not a good idea.

Several chapters had no problems worth working out in a REPL. So far
the list is chapters 1, 2, 3, 4, 5, 10, and 13. Stub files with no
problem number suffix exist as placeholders.

Chapter 6 ended up being a work through in a stream and has no problem
number designations.

There is some copy/paste reuse of procedures from earlier chapters. A
common load file or module is a better solution but would not be in
the spirit of the text or my work through.


Licensing:
---------

The text is still in copyright and still available to purchase, but
Harvey offers the text online for personal use. The original license
from the text is in `COPYLEFT.txt', my licensing can be found in
`LICENSE' and `MIT-LICENSE' for any derivative work I do.

To boil it down, their license is an early GPL. Anything I write I
consider public domain but for those who require a more explicit
license, you can choose between the UNLICENSE and the MIT License.

I'm quite sure there's nothing I've done here that anyone would want
to borrow and reuse. If you do, it's at your own risk.

Troy Brumley, blametroi@gmail.com, February 2025.

So let it be written,
So let it be done.
