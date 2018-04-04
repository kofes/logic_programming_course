ab([
  (accept(Xs):- initial(Q), accept(Xs, Q, [])),
  (accept([X|Xs], Q, S) :- delta(Q, X, S, Q1, S1), accept(Xs, Q1, S1)),
  (accept([], Q, []) :- final(Q))
]).

initial(q0).
final(q1).
final(q0).

delta(q0, a, S, q0, [a|S]).
delta(q0, b, [a|S], q1, S).
delta(q1, b, [a|S], q1, S).
%

make(R):- ab(L), resolve(L, R).

resolve(Program, Res):-
  findall(P, (member(C1, Program), reduce(C1, P)), Res).

reduce((Head:- Body), (PHead:- PBody)):-
  !,
  reduce(Head, PHead),
  reduce(Body, PBody).

reduce(true, true) :- !.
reduce((Head, Body), Res):-
  !,
  reduce(Head, PHead),
  reduce(Body, PBody),
  merge(PHead, PBody, Res).
reduce(Head, Body):-
  fold(Head, Body), !.
reduce(Head, Res):-
  unfold(Head), !,
  clause(Head, Body),
  reduce(Body, Res).
reduce(Head, Head).

unfold(initial(_)).
unfold(final(_)).
unfold(delta(_, _, _, _, _)).

fold(accept(Xs), anbn(Xs)).
fold(accept(Q, Xs, Q1), anbn(Q, Xs, Q1)).

merge(true, R, R):- !.
merge(R, true, R):- !.
merge(Head, Body, (Head, Body)).

test:-
  make(R),
  R = [
    (anbn(Q):-anbn(Q, q0, [])),
    (anbn([a|Ta], q0, Ta1):-anbn(Ta, q0, [a|Ta1])),
    (anbn([b|Tb], q0, [a|Tb1]):-anbn(Tb, q1, Tb1)),
    (anbn([b|Tb2], q1, [a|Tb3]):-anbn(Tb2, q1, Tb3)),
    (anbn([], q1, []):-true),
    (anbn([], q0, []):-true)
  ].
