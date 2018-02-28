#!/usr/bin/swipl
% Fibonacci function's realization
fib(0, 0).
fib(1, 1).
fib(N, F) :-
  N > 0,
  N1 is N - 1,
  N2 is N - 2,
  fib(N1, F1),
  fib(N2, F2),
  F is F1 + F2.
% fib's tests
test1 :-
  fib(0, 0).
test2 :-
  fib(1, 1).
test3 :-
  fib(2, 1).
test4 :-
  fib(3, 2).
test5 :-
  fib(4, 3).
test6 :-
  fib(5, 5).
test7 :-
  fib(6, 8).
test8 :-
  fib(7, 13).

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
