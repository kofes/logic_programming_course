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
simplifyOperation(*, X, X, X^2).
simplifyOperation(*, -X, X, -X^2).
simplifyOperation(*, C*X, X, C*X^2) :-
  number(C).
simplifyOperation(*, C, A/X, R/X) :-
  number(C),
  number(A),
  R is C * A.
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
% TODO: add many conditions
simplifyOperation(*, X, Y, X*Y).

simplifyOperation(/, 0, _, 0).
simplifyOperation(/, X, 1, X).
simplifyOperation(/, X, X, 1).
simplifyOperation(/, X*C, X, C).
simplifyOperation(/, X, X*C, 1/C).
% TODO: add many conditions
simplifyOperation(/, X, Y, X / Y).

simplifyOperation(^, 0, _, 0).
simplifyOperation(^, _, 0, 1).
simplifyOperation(^, X, 1, X).
% TODO: add many conditions
simplifyOperation(^, X, Y, X^Y).
