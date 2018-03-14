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

test1 :-
  accept([a, c]).

test2 :-
  accept([a, b, c]).

test3 :-
  accept([a, b, b, c]).

test4 :-
  accept([a, b, b, b, c]).

test5 :-
  not(accept([a])).

test5 :-
  not(accept([b])).

test5 :-
  not(accept([c])).

test6 :-
  not(accept([b, c])).

test7 :-
  not(accept([a, b])).
