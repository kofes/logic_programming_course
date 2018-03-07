#!/usr/bin/swipl
% merge sort realization
mergesort([], []).
mergesort([H], [H]).
mergesort(L, SL) :-
  len(L, N),
  half(N, M),
  left_sublist(L, M, H),
  right_sublist(L, M, T),
  mergesort(H, L1),
  mergesort(T, L2),
  merge(L1, L2, SL).
% getter of the left sublist [helper]
left_sublist(_, 0, []).
left_sublist([H|T1], s(N), [H|T2]) :-
  n_n(N),
  left_sublist(T1, N, T2).
% getter of the right sublist [helper]
right_sublist(T, 0, T).
right_sublist([_|T], s(N), L) :-
  n_n(N),
  right_sublist(T, N, L).
% merge of two sublist to one with sort [helper]
merge(L, [], L).
merge([], L, L).
merge([H1|T1], [H|T2], [H|T]) :-
  less(H, H1), % H < H1
  merge([H1|T1], T2, T).
merge([H|T1], [H1|T2], [H|T]) :-
  not(less(H1, H)), % H1 >= H
  merge(T1, [H1|T2], T).
% len helper
len([], 0).
len([_], 1).
len([_|T], s(N)) :-
  len(T, N).
% half helper
half(0, 0).
half(s(0), 0).
half(s(s(N)), s(M)) :-
  half(N, M).
% n_n helper
n_n(0).
n_n(s(N)) :- n_n(N).
% less helper
less(0, s(N)) :- n_n(N).
less(s(N1), s(N2))
  :- less(N1, N2).
% merge sort's test
test1 :-
  mergesort([], []).
test2 :-
  mergesort([0], [0]).
test3 :-
  mergesort([s(0), s(s(0))], [s(0), s(s(0))]).
test4 :-
  mergesort([s(s(s(0))), s(0), s(s(0))], [s(0), s(s(0)), s(s(s(0)))]).
test5 :-
  mergesort([s(s(s(0))), s(s(s(s(0)))), s(s(s(0)))], [s(s(s(0))), s(s(s(0))), s(s(s(s(0))))]).
test6 :-
  mergesort([
  s(s(0)),
  s(0),
  s(s(s(s(s(s(s(s(s(s(0)))))))))),
  s(s(s(s(s(0))))),
  s(s(s(0))),
  s(s(s(s(s(s(s(0))))))),
  s(s(s(s(s(s(0)))))),
  s(s(s(s(0)))),
  s(s(s(s(s(s(s(s(0)))))))),
  s(s(s(s(s(s(s(s(s(0)))))))))
  ], [
  s(0),
  s(s(0)),
  s(s(s(0))),
  s(s(s(s(0)))),
  s(s(s(s(s(0))))),
  s(s(s(s(s(s(0)))))),
  s(s(s(s(s(s(s(0))))))),
  s(s(s(s(s(s(s(s(0)))))))),
  s(s(s(s(s(s(s(s(s(0))))))))),
  s(s(s(s(s(s(s(s(s(s(0))))))))))
  ]).

:- initialization(main, main).

main(_) :-
  test1,
  test2,
  test3,
  test4,
  test5,
  test6.
