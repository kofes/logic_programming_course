#!/usr/bin/swipl
% diff complex function's realization
dfdg_dgdx(F, Y, G, X, R) :-
  dfdx(G, X, DG),
  dfdx(F, Y, DF),
  set(DF, Y, G, DCF),
  simplify(DCF * DG, R).

set(X, X, G, G).
set(C, _, _, C) :-
  atomic(C).
set(F, X, G, R) :-
  F =..[OP, U],
  op(OP),
  set(U, X, G, R1),
  R =..[OP, R1].
set(F, X, G, R) :-
  F =..[OP, U, V],
  op(OP),
  set(U, X, G, R1),
  set(V, X, G, R2),
  R =..[OP, R1, R2].

op(+).
op(-).
op(*).
op(/).
op(^).
op(sin).
op(cos).
op(ln).

diff(U, X, R) :-
  dfdx(U, X, A),
  writeln(A), !,
  simplify(A, R).

dfdx(X, X, 1) :-
  not(number(X)).

dfdx(C, X, 0) :-
  not(number(X)),
  atomic(C).

dfdx(-U, X, A) :-
  dfdx(U, X, A).

dfdx(U + V, X, A + B) :-
  dfdx(U, X, A),
  dfdx(V, X, B).

dfdx(U - V, X, A - B) :-
  dfdx(U, X, A),
  dfdx(V, X, B).

dfdx(U * V, X, A * V + U * B) :-
  dfdx(U, X, A),
  dfdx(V, X, B).

dfdx(U / V, X, (A * V - U * B) / (V^2)) :-
  dfdx(U, X, A),
  dfdx(V, X, B).

dfdx(ln(U), X, A / U) :-
  dfdx(U, X, A).

dfdx(U^V, X, (U^V) * A) :-
  dfdx(V * ln(U), X, A).

dfdx(sin(U), X, cos(U) * A) :-
  dfdx(U, X, A).

dfdx(cos(U), X, -sin(U) * A) :-
  dfdx(U, X, A).

% simplify function
simplify(X, X) :-
  atomic(X).
simplify(X, R) :-
  X =..[OP, U],
  simplify(U, A),
  simplifyOperation(OP, A, R).
simplify(X, R) :-
  X =..[OP, U, V],
  simplify(U, A),
  simplify(V, B),
  simplifyOperation(OP, A, B, R).
% simplifyOperation helper
simplifyOperation(-, X, R) :-
  number(X),
  R is -X.
simplifyOperation(-, X, -X).

simplifyOperation(sin, 0, 0).
simplifyOperation(sin, X, sin(X)).
simplifyOperation(cos, 0, 1).
simplifyOperation(cos, X, cos(X)).
simplifyOperation(ln, 1, 0).
simplifyOperation(ln, X, ln(X)).

simplifyOperation(+, X, Y, R) :-
  number(X),
  number(Y),
  R is X + Y.
simplifyOperation(+, X, 0, X).
simplifyOperation(+, 0, X, X).
simplifyOperation(+, X, X, 2*X).
simplifyOperation(+, X*Z, Y*Z, R*Z) :-
  number(X),
  number(Y),
  R is X + Y.
simplifyOperation(+, X*Y, Y, R*Y) :-
  number(X),
  R is X + 1.
simplifyOperation(+, Y, X*Y, R*Y) :-
  number(X),
  R is X + 1.
simplifyOperation(+, X^N, X^N, 2*X^N).
simplifyOperation(+, -X^N, X^N, 0).
simplifyOperation(+, X*Z^N, Y*Z^N, R*Z^N) :-
  number(X),
  number(Y),
  R is X + Y.
simplifyOperation(+, X*Y^N, Y^N, R*Y^N) :-
  number(X),
  R is X + 1.
simplifyOperation(+, Y^N, X*Y^N, R*Y^N) :-
  number(X),
  R is X + 1.
% TODO: add many conditions
simplifyOperation(+, X, Y, X+Y).

simplifyOperation(-, X, Y, R) :-
  number(X),
  number(Y),
  R is X - Y.
simplifyOperation(-, X, 0, X).
simplifyOperation(-, 0, X, -X).
simplifyOperation(-, X, X, 0).
simplifyOperation(-, X*Z, Y*Z, R*Z) :-
  number(X),
  number(Y),
  R is X - Y.
simplifyOperation(-, X*Y, Y, R*Y) :-
  number(X),
  R is X - 1.
simplifyOperation(-, Y, X*Y, R*Y) :-
  number(X),
  R is 1 - X.
simplifyOperation(-, X^N, X^N, 0).
simplifyOperation(-, -X^N, X^N, -2*X^N).
simplifyOperation(-, X*Z^N, Y*Z^N, R*Z^N) :-
  number(X),
  number(Y),
  R is X - Y.
simplifyOperation(-, X*Y^N, Y^N, R*Y^N) :-
  number(X),
  R is X - 1.
simplifyOperation(-, Y^N, X*Y^N, R*Y^N) :-
  number(X),
  R is 1 - X.
% TODO: add many conditions
simplifyOperation(-, X, Y, X-Y).

simplifyOperation(*, 0, _, 0).
simplifyOperation(*, _, 0, 0).
simplifyOperation(*, X, 1, X).
simplifyOperation(*, 1, X, X).
simplifyOperation(*, X, -Y, -R) :-
  simplifyOperation(*, X, Y, R).
simplifyOperation(*, X, X, X^2).
simplifyOperation(*, -X, X, -X^2).
simplifyOperation(*, C*X, X, C*X^2) :-
  number(C).
simplifyOperation(*, C1, C2*X, C*X) :-
  number(C1),
  number(C2),
  C is C1 * C2.
simplifyOperation(*, C1*X, C2, C*X) :-
  number(C1),
  number(C2),
  C is C1 * C2.
simplifyOperation(*, C, A/X, R1) :-
  number(C),
  number(A),
  R is C * A,
  simplifyOperation(/, R, X, R1).
simplifyOperation(*, A/X, C, R1) :-
  number(C),
  number(A),
  R is C * A,
  simplifyOperation(/, R, X, R1).
simplifyOperation(*, 1/X, Y, Y/X).
simplifyOperation(*, X^N, A/X, A*X^K) :-
  K is N-1,
  K =\= 1.
simplifyOperation(*, X^N, A/X, A*X) :-
  K is N-1,
  K =:= 1.
simplifyOperation(*, C*X, X^N, C*X^K) :-
  number(C),
  K is N+1.
simplifyOperation(*, C*X^N, X, C*X^K) :-
  number(C),
  K is N+1.
simplifyOperation(*, X, X^N, X^K) :-
  K is N+1.
simplifyOperation(*, X^N, X, X^K) :-
  K is N+1.
simplifyOperation(*, C1, C2*X^N, C*X^N) :-
  number(C1),
  number(C2),
  C is C1 * C2.
simplifyOperation(*, C1*X^N, C2, C*X^N) :-
  number(C1),
  number(C2),
  C is C1 * C2.
% TODO: add many conditions
simplifyOperation(*, X, Y, X*Y).

simplifyOperation(/, 0, _, 0).
simplifyOperation(/, X, 1, X).
simplifyOperation(/, X, X, 1).
simplifyOperation(/, X*C, X, C).
simplifyOperation(/, C, C*X, 1/X).
simplifyOperation(/, X, X*C, 1/C).
% TODO: add many conditions
simplifyOperation(/, X, Y, X / Y).

simplifyOperation(^, 0, _, 0).
simplifyOperation(^, _, 0, 1).
simplifyOperation(^, X, 1, X).
% TODO: add many conditions
simplifyOperation(^, X, Y, X^Y).

test1 :-
  dfdg_dgdx(x, x, y, y, 1).

test2 :-
  dfdg_dgdx(1, x, y, y, 0).

test3 :-
  dfdg_dgdx(x + x, x, y, y, 2).

test4 :-
  dfdg_dgdx(x + x^2, x, y, y, 1+2*x).

test5 :-
  dfdg_dgdx(x + 3*x^2, x, y, y, 1+6*x).

test6 :-
  dfdg_dgdx(1 + x + 3*x^2, x, y, y, 1+6*x).

test7 :-
  dfdg_dgdx(1 + x + 3*x^2, y, y, y, 0).

test8 :-
  dfdg_dgdx(ln(x), x, 2*y, y, 1/y).

test9 :-
  dfdg_dgdx(2*ln(x), x, 2*y, y, 2/y).

test10 :-
  dfdg_dgdx(sin(x), x, y, y, cos(y)).

test11 :-
  dfdg_dgdx(cos(x), x, y, y, -sin(y)).

test12 :-
  dfdg_dgdx(ln(x), x, sin(y), y, cos(y)/sin(y)).

test13 :-
  dfdg_dgdx(sin(x), x, cos(y), y, -((cos(cos(y)))*sin(y))).

test14 :-
  dfdg_dgdx(sin(x), x, cos(y), y, Res),
  Res = -((cos(cos(y)))*sin(y)).
