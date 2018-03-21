#!/usr/bin/swipl

queue(S) :-
  queue(S, Q-Q).

queue([enqueue(X)|Xs], Qh-Qt) :-
  enqueue(X, Qh-Qt, Q1h-Q1t),
  determine(Q1h, L),
  writeln([enqueue(X), acted |L]),
  queue(Xs, Q1h-Q1t).

queue([dequeue(X)|Xs], Qh-Qt) :-
  dequeue(X, Qh-Qt, Q1h-Q1t),
  determine(Q1h, L),
  writeln([dequeue(X), acted |L]),
  queue(Xs, Q1h-Q1t).

queue([], _).

enqueue(X, Qh-[X|Qt], Qh-Qt).
dequeue(X, [X|Qh]-Qt, Qh-Qt).

determine([H|_], []) :- var(H), !.
determine([], []).
determine([H|T], [H|T1]) :-
  determine(T, T1).

test :-
  queue([enqueue(1), enqueue(2), enqueue(3), dequeue(X), dequeue(Y)]),
  X = 1, Y = 2.
