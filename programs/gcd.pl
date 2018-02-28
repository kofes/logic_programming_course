#!/usr/bin/swipl
% greatest common difvisor function's realization
gcd(0, X, X).
gcd(X, 0, X).
gcd(X, X, X).
gcd(M, N, X) :-
  M < N,
  Q is N - M,
  gcd(M, Q, X).
gcd(M, N, X) :-
  M > N,
  gcd(N, M, X).
% gcd's tests
test1 :-
  gcd(0, 0, 0).
test2 :-
  gcd(0, 1, 1).
test3 :-
  gcd(1, 0, 1).
test4 :-
  gcd(1, 0, 1).
test5 :-
  gcd(5, 10, 5).
test6 :-
  gcd(4, 456, 4).
test7 :-
  gcd(256, 856, 8).

:- initialization(main, main).

main(_) :-
  test1,
  test2,
  test3,
  test4,
  test5,
  test6,
  test7.
