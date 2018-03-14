#!/usr/bin/swipl

position(T, T, [1]).

position(ST, T, Position) :-
  functor(T, F, Argc),
  T =.. [F|Args],
  position_list(ST, Args, Position, 1, Argc).

position_list(ST, [H|_], [I|Position], I, _) :-
  position(ST, H, Position).

position_list(ST, [_|T], Position, I, N) :-
  I < N,
  I1 is I+1,
  position_list(ST, T, Position, I1, N).
