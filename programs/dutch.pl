#!/usr/bin/swipl

dutch(Xs, RWB) :- distribute_dls(Xs, RWB-WB, WB-B, B-[]).

distribute_dls([red|Xs], [red|R]-R1, W, B) :-
  distribute_dls(Xs, R-R1, W, B).

distribute_dls([white|Xs], R, [white|W]-W1, B) :-
  distribute_dls(Xs, R, W-W1, B).

distribute_dls([blue|Xs], R, W, [blue|B]-B1) :-
  distribute_dls(Xs, R, W, B-B1).

distribute_dls([], R-R, W-W, B-B).
