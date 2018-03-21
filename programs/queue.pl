#!/usr/bin/swipl

queue(S) :-
  queue(S, Q-Q).

queue([enqueue(X)|Xs], Q) :-
  enqueue(X, Q, Q1h-Q1t),
  determine(Q1h, L),
  write("enqueue("), write(X), write(") acted to queue, result: "), writeln(L),
  queue(Xs, Q1h-Q1t).

queue([dequeue(X)|Xs], Q) :-
  dequeue(X, Q, Q1h-Q1t),
  determine(Q1h, L),
  write("dequeue("), write(X), write(") acted to queue, result: "), writeln(L),
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
  !, X = 1, Y = 2.
