;;; Simply Scheme

;; Troy Brumley, blametroi@gmail.com, early 2025.

;;; Chapter 25 Implementing the Spreadsheet Application.

;; For Chicken 5, load "required.scm" before this to establish the text book
;; environment for Simply Scheme. We load SRFI 78 in the exercises to support
;; testing.
(import srfi-78)
(check-reset!)
(check-set-mode! 'report-failed)

;;; Problem set:

(print "Chapter 25 problems 1 to 12 start...")

;; In addition to "required.scm" load "ch25--spread.scm" then run the
;; application with '(spreadsheet)'. The interactive entry is horked for
;; me, but I suspect that's my readline support for the Chicken REPL.
;; Reading from a file works fine.
;;
;; I added Vim style motion commands HJKL as synonyms for the BNPF from
;; Emacs that the authors used.
;;
;; Some answers will be in stream, and some will be in the changes to
;; "ch25--spread.scm". A diff against "ch24--spread.scm" will reveal them.


;; ----------------------------------------------
;; 25.1 The "magic numbers" 26 and 30 (and some numbers derived from them)
;; appear many times in the text of this program. It's easy to imagine
;; wanting more rows or columns.
;;
;; Create global variables total-cols and total-rows with values 26 and 30
;; respectively. Then modify the spreadsheet program to refer to these
;; variables rather than to the numbers 26 and 30 directly. When you're
;; done, redefine total-rows to be 40 and see if it works.

;; Changes as directed. There were a couple of 0-25/29 instead of 1-26/30
;; loops when dealing with the cell storage, those were done as (-
;; *total-????* 1)
;;
;; Tested and working.
;;
;; "ch24--02.txt" and "ch24--03.txt" are both valid tests.


;; ----------------------------------------------
;; 25.2 Suggest a way to notate columns beyond z. What procedures would
;; have to change to accommodate this?

;; The classic way is to double up, "...x y z aa ab ac ad...". The
;; functions in the utility section such as 'letter?' 'number->letter',
;; 'letter->number' most certainly. From there I'd test to see if that
;; was sufficient. Specifically:
;;
;; * Change the vector alphabet line ~560.
;; * Change the constant introduced in 25.1 *total-cols*
;; * More changes to 'show-label' than I'll bother with, but the label
;;   needs to drop a dash or blank somewhere when in the aa+ range of
;;   columns.
;; * The 'cell-name*' functions need to account for the column selector
;;   being more than one character. Minor changes to properly split the
;;   name into the column name and row number, along with mapping to
;;   and from numbers and letters.
;;
;; That's as far as I looked. Once we know the display works, and it does
;; immediately except for column the label width, we know that the bulk
;; of the program does not care about the external representation of column
;; names. The design has cleanly separated the external name from the
;; internal cell id.


;; ----------------------------------------------
;; 25.3 Modify the program so that the spreadsheet array is kept as a
;; single vector of 780 elements, instead of a vector of 30 vectors of 26
;; vectors. What procedures do you have to change to make this work? (It
;; shouldn't be very many.)

;; 'global-array-lookup' and neighbors such as 'init-array' and
;; 'fill-array-with-rows' and 'fill-row-with-cells'. Again, very well
;; isolated so that the cell id doesn't care how the cells are stored.


;; ----------------------------------------------
;; 25.4 The procedures get-function and get-command are almost identical in
;; structure; both look for an argument in an association list. They
;; differ, however, in their handling of the situation in which the
;; argument is not present in the list. Why?

;; This is a UI issue. Ideally the command loop will print an error and
;; not terminate the program. The function loop errors out which ends
;; the program. I'm not sure why the authors preferred one over the other
;; beyond this behavior.


;; ----------------------------------------------
;; 25.5 The reason we had to include the word id in each cell ID was so we
;; would be able to distinguish a list representing a cell ID from a list
;; of some other kind in an expression. Another way to distinguish cell IDs
;; would be to represent them as vectors, since vectors do not otherwise
;; appear within expressions. Change the implementation of cell IDs from
;; three-element lists to two-element vectors:
;;
;; (make-id 4 2) => #(4 2)
;;
;; Make sure the rest of the program still works.

;; Changing 'make-id' to create a two element vector for col and row, and
;; updating the accessors 'id-column' and 'id-row' to pull the right
;; element from the vector, and finally changing 'id?' so that it checks
;; for a vector and not a list. After those isolated changes everything
;; seems to be working fine. The pascal's triangle and diner check
;; calculator work as before.


;; ----------------------------------------------
;; 25.6 The put command can be used to label a cell by using a quoted word
;; as the "formula." How does that work? For example, how is such a formula
;; translated into an expression? How is that expression evaluated? What if
;; the labeled cell has children?

;; The label (string or symbol) is just dropped into the cell. These are
;; self evaluating. If the receiving cell is empty, nothing extra happens.
;; If the cell is a dependent upon another cell, it replaces the cell
;; contents and the dependencies are removed.

;; ----------------------------------------------
;; 25.7 Add commands to move the "window" of cells displayed on the screen
;; without changing the selected cell. (There are a lot of possible user
;; interfaces for this feature; pick anything reasonable.)

;; I used the WASD gaming keys to page up left down right. Up and down work
;; fine, left and right aren't resetting the corner correctly. I'm not
;; going to chase that further. The basics are:
;;
;; (1) add the new command table entries and corresponding procedures.
;;
;; (2) the procedures parallel those for selected cell, just change
;;     some of the corresponding variables.
;;
;; The only problem I had with up and down was making sure that there were
;; actual rows to page to by increasing the total rows (and total columns).
;;
;; I'm not sure why left and right aren't working, but as I said, it's not
;; worth chasing for this exercise.


;; ----------------------------------------------
;; 25.8 Modify the put command so that after doing its work it prints
;;
;; 14 cells modified
;;
;; (but, of course, using the actual number of cells modified instead of
;; 14). This number may not be the entire length of a row or column because
;; put doesn't change an existing formula in a cell when you ask it to set
;; an entire row or column.


;; ----------------------------------------------
;; 25.9 Modify the program so that each column remembers the number of
;; digits that should be displayed after the decimal point (currently
;; always 2). Add a command to set this value for a specified column. And,
;; of course, modify print-screen to use this information.


;; ----------------------------------------------
;; 25.10 Add an undo command, which causes the effect of the previous
;; command to be nullified. That is, if the previous command was a cell
;; selection command, undo will return to the previously selected cell. If
;; the previous command was a put, undo will re-put the previous
;; expressions in every affected cell. You don't need to undo load or exit
;; commands. To do this, you'll need to modify the way the other commands
;; work.


;; ----------------------------------------------
;; 25.11 Add an accumulate procedure that can be used as a function in
;; formulas. Instead of specifying a sequence of cells explicitly, in a
;; formula like
;;
;;  (put (+ c2 c3 c4 c5 c6 c7) c10)
;;
;; we want to be able to say
;;
;; (put (accumulate + c2 c7) c10)
;;
;; In general, the two cell names should be taken as corners of a
;; rectangle, all of whose cells should be included, so these two commands
;; are equivalent:
;;
;; (put (accumulate * a3 c5) d7)
;; (put (* a3 b3 c3 a4 b4 c4 a5 b5 c5) d7)
;;
;; Modify pin-down to convert the accumulate form into the corresponding
;; spelled-out form.


;; ----------------------------------------------
;; 25.12 Add variable-width columns to the spreadsheet. There should be a
;; command to set the print width of a column. This may mean that the
;; spreadsheet can display more or fewer than six columns.


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; And that's the end of this section. Report test results and reset
;;; counters.

(check-report)
(check-reset!)
(check-set-mode! 'report-failed)

(print "Chapter 25 problems 1 to 12 end...")
