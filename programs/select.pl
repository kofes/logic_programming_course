#!/usr/bin/swipl

select(_, [], []).

select(H, [H|T1], T1) :- !.

select(H, [H1|T], [H1|T1]) :-
  select(H, T, T1).
