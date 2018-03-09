#!/usr/bin/swipl
% diff function's realization
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
  s(OP, A, R).
simplify(X, R) :-
  X =..[OP, U, V],
  simplify(U, A),
  simplify(V, B),
  s(OP, A, B, R).
% s helper
s(-, X, R) :-
  number(X),
  R is -X.
s(-, X, -X).

s(sin, 0, 0).
s(sin, X, sin(X)).
s(cos, 0, 1).
s(cos, X, cos(X)).
s(ln, 1, 0).
s(ln, X, ln(X)).

s(+, X, Y, R) :-
  number(X),
  number(Y),
  R is X + Y.
s(+, X, 0, X).
s(+, 0, X, X).
s(+, X, X, 2*X).
s(+, X*Z, Y*Z, R*Z) :-
  number(X),
  number(Y),
  R is X + Y.
s(+, X*Y, Y, R*Y) :-
  number(X),
  R is X + 1.
s(+, Y, X*Y, R*Y) :-
  number(X),
  R is X + 1.
s(+, X^N, X^N, 2*X^N).
s(+, -X^N, X^N, 0).
s(+, X*Z^N, Y*Z^N, R*Z^N) :-
  number(X),
  number(Y),
  R is X + Y.
s(+, X*Y^N, Y^N, R*Y^N) :-
  number(X),
  R is X + 1.
s(+, Y^N, X*Y^N, R*Y^N) :-
  number(X),
  R is X + 1.
% TODO: add many conditions
s(+, X, Y, X+Y).

s(-, X, Y, R) :-
  number(X),
  number(Y),
  R is X - Y.
s(-, X, 0, X).
s(-, 0, X, -X).
s(-, X, X, 0).
s(-, X*Z, Y*Z, R*Z) :-
  number(X),
  number(Y),
  R is X - Y.
s(-, X*Y, Y, R*Y) :-
  number(X),
  R is X - 1.
s(-, Y, X*Y, R*Y) :-
  number(X),
  R is 1 - X.
s(-, X^N, X^N, 0).
s(-, -X^N, X^N, -2*X^N).
s(-, X*Z^N, Y*Z^N, R*Z^N) :-
  number(X),
  number(Y),
  R is X - Y.
s(-, X*Y^N, Y^N, R*Y^N) :-
  number(X),
  R is X - 1.
s(-, Y^N, X*Y^N, R*Y^N) :-
  number(X),
  R is 1 - X.
% TODO: add many conditions
s(-, X, Y, X-Y).

s(*, 0, _, 0).
s(*, _, 0, 0).
s(*, X, 1, X).
s(*, 1, X, X).
s(*, X, X, X^2).
s(*, -X, X, -X^2).
s(*, C*X, X, C*X^2) :-
  number(C).
s(*, C, A/X, R/X) :-
  number(C),
  number(A),
  R is C * A.
s(*, X^N, A/X, A*X^K) :-
  K is N-1,
  K =\= 1.
s(*, X^N, A/X, A*X) :-
  K is N-1,
  K =:= 1.
s(*, C*X, X^N, C*X^K) :-
  number(C),
  K is N+1.
s(*, C*X^N, X, C*X^K) :-
  number(C),
  K is N+1.
s(*, X, X^N, X^K) :-
  K is N+1.
s(*, X^N, X, X^K) :-
  K is N+1.
% TODO: add many conditions
s(*, X, Y, X*Y).

s(/, 0, _, 0).
s(/, X, 1, X).
s(/, X, X, 1).
s(/, X*C, X, C).
s(/, X, X*C, 1/C).
% TODO: add many conditions
s(/, X, Y, X / Y).

s(^, 0, _, 0).
s(^, _, 0, 1).
s(^, X, 1, X).
% TODO: add many conditions
s(^, X, Y, X^Y).
