/*
    translate(Grammar,Program) :-
	Program is the Prolog equivalent of the context-free
	grammar Grammar.
*/
        translate([Rule|Rules],[Clause|Clauses]) :-
           translate_rule(Rule,Clause),
           translate(Rules,Clauses).
        translate([ ],[ ]).

/*
        translate_rule(GrammarRule,PrologClause) :-
           PrologClause is the Prolog equivalent of the grammar
           rule GrammarRule.
*/
	translate_rule((Lhs --> Rhs),(Head :- Body)) :-
	   translate_head(Lhs,Head,Xs-Ys),
	   translate_body(Rhs,Body,Xs-Ys),!.

        translate_head(A,A1,Xs) :-
           translate_goal(A,A1,Xs).

	translate_body((A,B),(A1,B1),Xs-Ys) :-
	   !, translate_body(A,A1,Xs-Xs1), translate_body(B,B1,Xs1-Ys).
        translate_body(A,A1,Xs) :-
           translate_goal(A,A1,Xs).

        translate_goal(A,A1,DList) :-
           nonterminal(A), functor(A1,A,1), arg(1,A1,DList).
        translate_goal(Terms,connect(Terms,S),S) :-
           terminals(Terms).

	nonterminal(A) :- atom(A).

	terminals(Xs) :- list(Xs).

	list([]).
	list([_|Xs]) :- list(Xs).

%     Program 18.9: Translating grammar rules to Prolog clauses

test1 :-
  translate([(s --> as, bs, cs), (as --> [a]), (as --> []), (bs --> [b]), (bs --> []), (cs --> [c]), (cs --> [])], R),
  R = [
    (s(ABC-Xs):-as(ABC-BC),bs(BC-C),cs(C-Xs)),
    (as(ABC1-BC1):-connect([a],ABC1-BC1)),
    (as(ABC2-BC2):-connect([],ABC2-BC2)),
    (bs(BC1-C1):-connect([b],BC1-C1)),
    (bs(BC2-C2):-connect([],BC2-C2)),
    (cs(C1-Xs1):-connect([c],C1-Xs1)),
    (cs(C2-Xs2):-connect([],C2-Xs2))
  ].

test2 :-
  translate([
    (s --> as, bs, cs),
    (as --> [a]),
    (as --> []),
    (bs --> [b]),
    (bs --> []),
    (cs --> [c]),
    (cs --> [])
  ], [
      (s(ABC-Xs):-as(ABC-BC),bs(BC-C),cs(C-Xs)),
      (as(ABC1-BC1):-connect([a],ABC1-BC1)),
      (as(ABC2-BC2):-connect([],ABC2-BC2)),
      (bs(BC1-C1):-connect([b],BC1-C1)),
      (bs(BC2-C2):-connect([],BC2-C2)),
      (cs(C1-Xs1):-connect([c],C1-Xs1)),
      (cs(C2-Xs2):-connect([],C2-Xs2))
  ]).

test3 :-
  translate(In, []),
  In = [].

test4 :-
  not(translate(_, [
      (s(_-_):-[a,b,c])
  ])).
