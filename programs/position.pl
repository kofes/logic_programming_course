#!/usr/bin/swipl

% Возможные варианты вызова:
% |ST| T| Position|
% |- |+ |-        | -> генерирует все возможные варианты ST и Position
% |+ |+ |-        | -> Выводит первую позицию ST в терме T
% |- |+ |+        | -> Выводит ST, находящийся в позиции Position в терме T
% |+ |+ |+        | -> Проверяет на выводимость функцию, при заданных параметрах ST, T, Position

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

test8 :-
  position(ST, f(z, y, y(g(a, x))), [3, 1, 2]),
  ST = x.

test9 :-
  position(x, f(z, y, y(g(a, x))), Pos),
  Pos = [3, 1, 2].

test10 :-
  position(ST,
    f( %[]
      z( %[1]
        x,  %[1, 1]
        k( %[1, 2]
          u, %[1, 2, 1]
          v %[1, 2, 2]
        )
      ),
      g( %[2]
        y %[2, 1]
      ),
      z %[3]
    ), Pos),
  (
    ST = f(z(x, k(u, v)), g(y), z), Pos = [];
    ST = z(x, k(u, v)), Pos = [1];
    ST = x, Pos = [1, 1];
    ST = k(u, v), Pos = [1, 2];
    ST = u, Pos = [1, 2, 1];
    ST = v, Pos = [1, 2, 2];
    ST = g(y), Pos = [2];
    ST = y, Pos = [2, 1];
    ST = z, Pos = [3]
  ).
