:- use_module(library(clpfd)).
:- use_module(library(apply)).

key_len_l(L, Len-L):-
  length(L, Len1),
  Len is -Len1.

longest_list(Ls, Ll):-
  maplist(key_len_l, Ls, KeyedLs),
  keysort(KeyedLs, [_-Ll|_]).

test0:-
  longest_list([[]], []).

test1:-
  longest_list([[_], [_, _, _], [_, _]], L),
  L = [_, _, _].

test3:-
  longest_list([[1], [3, 2, 1], [-1, a]], L),
  L = [3, 2, 1].
