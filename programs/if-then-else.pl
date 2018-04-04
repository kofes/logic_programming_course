if_then_else(C, T, A) --> block(_),
  "if ", block(C1), {\+ phrase(if, C1) },
  keyword("then"), block(T1), {\+ phrase(then, T1) },
  keyword("else"), block(A1), {\+ phrase(else, A1) }, ";",
  block(_),
  {atom_codes(C, C1), atom_codes(T, T1), atom_codes(A, A1)}.

block([]) --> [].
block([L|T]) --> [L], block(T).

keyword(KW) --> " ", KW, " ".
keyword(KW) --> "\n", KW, " ".

if --> block(_), keyword("if"), block(_).
then --> block(_), keyword("then"), block(_).
else --> block(_), keyword("else"), block(_).

test0:-
  phrase_from_file(if_then_else(C, T, A), 'test0.in'),
  C = true,
  T = ok,
  A = bad,
  !.

test1:-
  \+ phrase_from_file(if_then_else(_, _, _), 'test1.in').

test2:-
  phrase_from_file(if_then_else(C, T, A), 'test2.in'),
  C = true,
  T = 'ok\nok',
  A = bad,
  !.

test3:-
  phrase_from_file(if_then_else(C, T, A), 'test3.in'),
  (
    C = true, T = ok, A = bad;
    C = false, T= bad, A = ok
  ).
