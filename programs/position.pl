#!/usr/bin/swipl

position(T, T, []).

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

test1 :-
  position(x, x, []).

test2 :-
  position(x, x+y, [1]).

test3 :-
  position(x, f(x), [1]).

test4 :-
  position(x, f(y, x), [2]).

test5 :-
  position(x, f(z, x, y), [2]).

test6 :-
  position(x, f(z, g(x), y), [2, 1]).

test7 :-
  position(x, f(z, y, y(g(a, x))), [3, 1, 2]).
