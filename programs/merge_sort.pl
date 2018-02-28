#!/usr/bin/swipl
% merge sort realization
mergesort([], []).
mergesort([H], [H]).
mergesort(L, SL) :-
  length(L, N),
  M is N // 2,
  left_sublist(L, M, H),
  right_sublist(L, M, T),
  mergesort(H, L1),
  mergesort(T, L2),
  merge(L1, L2, SL).
% getter of the left sublist [helper]
left_sublist(_, 0, []).
left_sublist([H|T1], N, [H|T2]) :-
  N1 is N - 1,
  left_sublist(T1, N1, T2).
% getter of the right sublist [helper]
right_sublist(T, 0, T).
right_sublist([_|T], N, L) :-
  N1 is N - 1,
  right_sublist(T, N1, L).
% merge of two sublist to one with sort [helper]
merge(L, [], L).
merge([], L, L).
merge([H1|T1], [H|T2], [H|T]) :-
  H < H1,
  merge([H1|T1], T2, T).
merge([H|T1], [H1|T2], [H|T]) :-
  H =< H1,
  merge(T1, [H1|T2], T).
% merge sort's test
test1 :-
  mergesort([], []).
test2 :-
  mergesort([1], [1]).
test3 :-
  mergesort([1, 2], [1, 2]).
test4 :-
  mergesort([3, 1, 2], [1, 2, 3]).
test5 :-
  mergesort([3, 4, 3], [3, 3, 4]).
test6 :-
  mergesort([2, 1, 10, 5, 3, 7, 6, 4, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]).

:- initialization(main, main).

main(_) :-
  test1,
  test2,
  test3,
  test4,
  test5,
  test6.
