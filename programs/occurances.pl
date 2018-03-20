#!/usr/bin/swipl

% Возможные варианты вызова:
% |ST| T| N|
% |- |+ |- | -> генерирует все возможные ST, стоящие в "начальной позиции" и количество их вхождений в терм T
% |+ |+ |- | -> Выводит количество вхождений ST в терм T
% |+ |+ |+ | -> Проверяет на выводимость функцию, при заданных параметрах ST, T, N

occurances(T, T, 1).
occurances(ST, T, 0) :-
  not(subterm(ST, T)).

occurances(ST, T, N) :-
  compound(T),
  T =.. [_|Args],
  occurances_list(ST, Args, N).

occurances_list(_, [], 0).

occurances_list(ST, [H|T], N) :-
  occurances(ST, H, N1),
  occurances_list(ST, T, N2),
  N is N1 + N2.

subterm(T, T).
subterm(ST, T):-
  compound(T),
  T =.. [_|Args],
  subterm_list(ST, Args).

subterm_list(ST, [Arg|_]) :-
  subterm(ST, Arg).

subterm_list(ST, [_|Args]) :-
  subterm_list(ST, Args).

test1 :-
  occurances(x, x, 1).

test2 :-
  occurances(x, f(x), 1).

test3 :-
  occurances(x, f(x, x), 2).

test4 :-
  occurances(x, f(x, x + x), 3).

test5 :-
  occurances(x, f(x, x), N),
  N = 2.

test6 :-
  occurances(ST, f(x, x), N),
  (
    (ST = f(x, x), N = 1);
    (ST = x, N = 2)
  ).
