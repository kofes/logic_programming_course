translate([Rule|Rules],[Clause|Clauses]) :-
  translate_rule(Rule,Clause),
  translate(Rules,Clauses).
translate([ ],[ ]).

translate_rule((Lhs --> Rhs), (Head :- Body)) :-
  translate_head(Lhs, Head, Xs-Ys),
  translate_body(Rhs, Body, Xs-Ys),
  !.

translate_head(A, A1, Xs) :-
  translate_goal(A, A1, Xs).

translate_body((A, B), (A1, B1), Xs-Zs) :-
  !,
  translate_body(A, A1, Xs-Ys),
  translate_body(B, B1, Ys-Zs).

translate_body(A, A1, Xs) :-
  translate_goal(A, A1, Xs).

translate_goal(A, A1, DList) :-
  nonterminal(A),
  functor(A, F, N),
  N1 is N + 1,
  functor(A1, F, N1),
  A =.. [F|Args],
  set_args(1, A1, Args),
  arg(N1, A1, DList).

translate_goal(Terms, connect(Terms, S), S) :-
  terminals(Terms).

translate_goal(Condition, ExtractedConditions, _) :-
  extractCondition(Condition, ExtractedConditions).

% helpers
set_args(_, _, []).
set_args(N, A1, [H|Args]) :-
  N1 is N + 1,
  arg(N, A1, H),
  set_args(N1, A1, Args).

extractCondition({Cond}, Cond) :-
  not(condition(Cond)).

nonterminal(A) :-
  not(terminals(A)),
  not(condition(A)).
terminals(Xs) :- list(Xs).
condition({_}).

list([]).
list([_|Xs]) :- list(Xs).

test1 :-
  translate([
    (append([]) --> []),
    (append([H|T]) --> [H], append(T))
  ], R),
  R = [
    (append([], Li1-Lo1):-connect([], Li1-Lo1)),
    (append([H|T], Li2-Lo2):-connect([H], Li2-L12), append(T, L12-Lo2))
  ].

test2 :-
  translate([
    (append([]) --> []),
    (append([H|T]) --> [H], append(T))
  ], [
    (append([], Li1-Lo1):-connect([], Li1-Lo1)),
    (append([H|T], Li2-Lo2):-connect([H], Li2-L12), append(T, L12-Lo2))
  ]).

test3 :-
  translate(In, []),
  In = [].
test4 :-
  translate([
    (s(N) --> a(Na), b(Nb), c(Nc), {N is Na + Nb + Nc}),
    (a(N) --> [a], a(N1), {N is N1 + 1}),
    (a(0) --> []),
    (b(N) --> [b], b(N1), {N is N1 + 1}),
    (b(0) --> []),
    (c(N) --> [c], c(N1), {N is N1 + 1}),
    (c(0) --> [])
  ], R),
  R = [(
    s(N, Li-Lo) :-
      a(Na, Li-L1),
      b(Nb, L1-L2),
      c(Nc, L2-Lo),
      N is Na + Nb + Nc
  ), (
    a(N_a, Li_a-Lo_a) :-
      connect([a], Li_a-L1_a),
      a(N1_a, L1_a-Lo_a),
      N_a is N1_a + 1
  ), (
    a(0, Li_a1-Lo_a2) :-
      connect([], Li_a1-Lo_a2)
  ), (
    b(N_b, Li_b-Lo_b) :-
      connect([b], Li_b-L1_b),
      b(N1_b, L1_b-Lo_b),
      N_b is N1_b + 1
  ), (
    b(0, Li_b1-Lo_b1) :-
      connect([], Li_b1-Lo_b1)
  ), (
    c(N_c, Li_c-Lo_c) :-
      connect([c], Li_c-L1_c),
      c(N1_c, L1_c-Lo_c),
      N_c is N1_c + 1
  ), (
    c(0, Li_c1-Lo_c1) :-
      connect([], Li_c1-Lo_c1)
  )].
