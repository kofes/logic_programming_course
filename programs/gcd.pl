#!/usr/bin/swipl
% greatest common difvisor function's realization
gcd(0, s(N), s(N)) :- n_n(N).
gcd(s(N), 0, s(N)) :- n_n(N).
gcd(s(N), s(N), s(N)) :- n_n(N).
gcd(M, N, X) :-
  greater(N, M), % N => M
  plus(M, Q, N), % find Q
  gcd(M, Q, X).
gcd(M, N, X) :-
  greater(M, N), % M > N
  gcd(N, M, X).
% plus helper
plus(0, X, X).
plus(X, 0, X).
plus(s(X), Y, s(Z)) :-
  plus(X, Y, Z).
% greater helper
greater(s(N), 0) :- n_n(N).
greater(s(N1), s(N2)) :-
  greater(N1, N2).
% n_n helper
n_n(0).
n_n(s(N)) :- n_n(N).
% gcd's tests
test1 :-
  not(gcd(0, 0, 0)).
test2 :-
  gcd(0, s(0), s(0)).
test3 :-
  gcd(s(0), 0, s(0)).
test4 :-
  gcd(s(s(s(s(s(0))))), s(s(s(s(s(s(s(s(s(s(0)))))))))), s(s(s(s(s(0)))))).

:- initialization(main, main).

main(_) :-
  test1,
  test2,
  test3,
  test4.
