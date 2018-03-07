#!/usr/bin/swipl
% Fibonacci function's realization
fib(0, 0).
fib(s(0), s(0)).
fib(s(s(N)), F) :-
  fib(s(N), F1),
  fib(N, F2),
  plus(F1, F2, F).
% plus helper
plus(0, X, X) :- n_n(X).
plus(X, 0, X) :- n_n(X).
plus(s(X), Y, s(Z)) :-
  plus(X, Y, Z).
% n_n helper
n_n(0).
n_n(s(N)) :- n_n(N).
% fib's tests
test1 :-
  fib(0, 0).
test2 :-
  fib(s(0), s(0)).
test3 :-
  fib(s(s(0)), s(0)).
test4 :-
  fib(s(s(s(0))), s(s(0))).
test5 :-
  fib(s(s(s(s(0)))), s(s(s(0)))).
test6 :-
  fib(s(s(s(s(s(0))))), s(s(s(s(s(0)))))).
test7 :-
  fib(s(s(s(s(s(s(0)))))), s(s(s(s(s(s(s(s(0))))))))).
test8 :-
  fib(s(s(s(s(s(s(s(0))))))), s(s(s(s(s(s(s(s(s(s(s(s(s(0)))))))))))))).

:- initialization(main, main).

main(_) :-
  test1,
  test2,
  test3,
  test4,
  test5,
  test6,
  test7,
  test8.
