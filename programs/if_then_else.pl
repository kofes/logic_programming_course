#!/usr/bin/swipl

if_then_else(IF, THEN, ELSE) :-
  IF -> THEN, !;
  ELSE.

if_then(IF, THEN) :-
  IF -> THEN, !.
