:- use_module(library(clpfd)).
:- use_module(library(apply)).

max(X, min, M) :- M is X, !.
max(X, Y, M) :- X #> Y, M = X.
max(X, Y, M) :-  X #=< Y, M = Y.

max_l(L, M) :- foldl(max, L, min, M).

test0:-
  max_l([], min).

test1:-
  max_l([0], 0).

test2:-
  max_l([0,1,2,3], 3).

test3:-
  max_l([-1, 30, -2], M),
  M = 30.
