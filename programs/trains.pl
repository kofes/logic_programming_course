#!/usr/bin/swipl

:- use_module(library(clpfd)).
:- use_module(library(apply)).

trains([
  [1,2,0,1],
  [2,3,4,5],
  [2,3,0,1],
  [3,4,5,6],
  [3,4,2,3],
  [3,4,8,9]
]).

findPath(A, B, Path) :-
  path(A, B, Path),
  maplist(label, Path).

path(A, A, [[]]).

path(A, B, Ps) :-
  Ps = [[A, B, _T0, _T1]],
  trains(Ts),
  tuples_in(Ps, Ts).

path(A, B, Ps) :-
  Ps = [
    [A, C, T0, T1],
    [C, D, T2, T3]
    |Ps1],
  T2 #> T1,
  trains(Ts),
  tuples_in([[A, C, T0, T1]], Ts),
  path(C, B, [[C, D, T2, T3]|Ps1]).

test1 :-
  findPath(1, 1, [[]]).

test2 :-
  findPath(1, 2, [[1, 2, 0, 1]]).

test3 :-
  findPath(1, 3, [[1, 2, 0, 1], [2, 3, 4, 5]]).

test4 :-
  findPath(1, 3, Path),
  Path = [[1, 2, 0, 1], [2, 3, 4, 5]].

test5 :-
  findPath(A, B, [[1, 2, 0, 1], [2, 3, 4, 5]]),
  A = 1,
  B = 3.

test6 :-
  findPath(A, 3, [[1, 2, 0, 1]|T]),
  A = 1,
  T = [[2, 3, 4, 5]].

test7 :-
  findPath(1, B, [L, [2, 3, 4, 5]]),
  B = 3,
  L = [1, 2, 0, 1].

test8 :-
  findPath(1, B, Path),
  (
    B = 1, Path = [[]];
    B = 2, Path = [[1, 2, 0, 1]];
    B = 3, Path = [[1, 2, 0, 1], [2, 3, 4, 5]];
    B = 4, Path = [[1, 2, 0, 1], [2, 3, 4, 5], [3, 4, 8, 9]]
  ).

test9 :-
  findPath(A, 3, Path),
  (
    A = 3, Path = [[]];
    A = 2, Path = [[2, 3, 0, 1]];
    A = 2, Path = [[2, 3, 4, 5]];
    A = 1, Path = [[1, 2, 0, 1], [2, 3, 4, 5]]
  ).
