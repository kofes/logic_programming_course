#!/usr/bin/swipl

accept(Xs) :-
  initial(Q),
  accept(Xs, Q, []).

accept([X|Xs], Q, S) :-
  delta(Q, X, S, Q1, S1),
  accept(Xs, Q1, S1).

accept([], Q, []) :-
  final(Q).

% custom rules
initial(q0).
final(q1).
final(q0).

delta(q0, a, S, q0, [a|S]).
delta(q0, b, [a|S], q1, S).
delta(q1, b, [a|S], q1, S).

test1 :-
  accept([]).

test2 :-
  accept([a, b]).

test3 :-
  accept([a, a, b, b]).

test4 :-
  not(accept([a])).

test5 :-
  not(accept([b])).

test5 :-
  not(accept([a, a, b])).

test6 :-
  not(accept([a, b, b])).
