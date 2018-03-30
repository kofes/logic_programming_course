        s(As-Xs) :-  a(As-Bs), b(Bs-Cs), c(Cs-Xs).

        a(Xs-Ys) :-  connect([a],Xs-Xs1), a(Xs1-Ys).
        a(Xs-Ys) :-  connect([ ],Xs-Ys).

        b(Xs-Ys) :-  connect([b],Xs-Xs1), b(Xs1-Ys).
        b(Xs-Ys) :-  connect([ ],Xs-Ys).

        c(Xs-Ys) :-  connect([c],Xs-Xs1), c(Xs1-Ys).
        c(Xs-Ys) :-  connect([ ],Xs-Ys).

        connect([ ],Xs-Xs).
        connect([W|Ws],[W|Xs]-Ys) :-  connect(Ws,Xs-Ys).

%     Program 18.8: A Prolog program parsing the language a*b*c*

test1 :-
  s([]-[]).

test2 :-
  s([a,b,c,c]-[]).

test3 :-
  not(s([a,c,d]-[])).

test4 :-
  s([a,b,c]-Xs),
  (
    Xs = [];
    Xs = [c];
    Xs = [b,c];
    Xs = [a,b,c]
  ).

test5 :-
  s([a,b,d,c]-Xs),
  (
    Xs = [d,c];
    Xs = [b,d,c];
    Xs = [a,b,d,c]
  ).
