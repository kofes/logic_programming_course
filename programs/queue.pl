#!/usr/bin/swipl

queue(S) :-
  queue(S, Q-Q).

queue([enqueue(X)|Xs], Q) :-
  enqueue(X, Q, Q1),
  queue(Xs, Q1).

queue([dequeue(X)|Xs], Q) :-
  dequeue(X, Q, Q1),
  queue(Xs, Q1).

queue([], _).

enqueue(X, Qh-[X|Qt], Qh-Qt).
dequeue(X, [X|Qh]-Qt, Qh-Qt).

test :-
  queue([enqueue(1), enqueue(2), enqueue(3), dequeue(X), dequeue(Y)]),
  X = 1, Y = 2.
