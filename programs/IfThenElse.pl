if_then(As-Xs) :-
  if(As-Bs),
  block(Bs-Cs),
  then(Cs-Ds),
  block(Ds-Xs).

if_then_else(As-Xs) :-
  if(As-Bs),
  block(Bs-Cs),
  then(Cs-Ds),
  block(Ds-Es),
  else(Es-Fs),
  block(Fs-Xs).

if(Xs-Ys) :- connect([if], Xs-Ys).
then(Xs-Ys) :- connect([then], Xs-Ys).
else(Xs-Ys) :- connect([else], Xs-Ys).

block(Xs-Zs) :- connect([_], Xs-Ys), block(Ys-Zs).
block(Xs-Ys) :- connect([], Xs-Ys).

connect([ ],Xs-Xs).
connect([W|Ws],[W|Xs]-Ys) :-  connect(Ws,Xs-Ys).

test1 :- if_then_else([if, true, then, ok, else, bad]-[]).
test2 :- not(if_then_else([]-[])).
test3 :- not(if_then_else([if, else]-[])).
test4 :- not(if_then_else([if, then]-[])).
test5 :- not(if_then_else([else, if, then]-[])).
test6 :- not(if_then_else([else, then]-[])).
