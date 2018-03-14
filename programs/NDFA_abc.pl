#!/usr/bin/swipl

accept(Xs) :-
  initial(Q),
  accept(Xs, Q).

accept([X|Xs], Q) :-
  delta(Q, X, Q1),
  accept(Xs, Q1).

accept([], Q) :-
  final(Q).

% custom rules
initial(q0).

final(q2).

delta(q0, a, q1).
delta(q1, b, q1).
delta(q1, c, q2).
