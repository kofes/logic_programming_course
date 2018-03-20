#!/usr/bin/swipl

dutch(Xs, RWB) :-
  distribute_dls(Xs, RWB-WB, WB-B, B-[]).

distribute_dls([red(X)|Xs], R-R1, W, B) :-
  distribute_dls(Xs, R-[red(X)|R1], W, B).

distribute_dls([white(X)|Xs], R, W-W1, B) :-
  distribute_dls(Xs, R, W-[white(X)|W1], B).

distribute_dls([blue(X)|Xs], R, W, B-B1) :-
  distribute_dls(Xs, R, W, B-[blue(X)|B1]).

distribute_dls([], R-R, W-W, B-B).

test1 :-
  dutch([], []).

test2 :-
  dutch([red(_)], [red(_)]).

test3 :-
  dutch([white(_)], [white(_)]).

test4 :-
  dutch([blue(_)], [blue(_)]).

test5 :-
  dutch([blue(_), red(_)], [red(_), blue(_)]).

test6 :-
  dutch([blue(_), white(_)], [white(_), blue(_)]).

test7 :-
  dutch([red(_), white(_)], [red(_), white(_)]).

test8 :-
  dutch([blue(_), red(_), white(_)], [red(_), white(_), blue(_)]).

test9 :-
  dutch([red(1), red(2)], [red(2), red(1)]).

test10 :-
  dutch([red(10), white(5)], [red(10), white(5)]).

test11 :-
  dutch([red(10), white(5)], Res),
  Res = [red(10), white(5)].
