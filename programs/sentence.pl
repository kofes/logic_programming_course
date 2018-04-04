sentence(sent(NP, VP)) -->
  noun_phrase(NP, N),
  verb_phrase(VP, N).

noun_phrase(np(D, N), Num) -->
  determiner(D, Num),
  noun_phrase2(N, Num).
noun_phrase(np(N), Num) -->
  noun_phrase2(N, Num).

noun_phrase2(np2(A, N), Num) -->
  adjective(A),
  noun_phrase2(N, Num).
noun_phrase2(np2(N), Num) -->
  noun(N, Num).

verb_phrase(vp(V), Num) -->
  verb(V, Num).
verb_phrase(vp(V, N), Num) -->
  verb(V, Num),
  noun_phrase(N, _).

determiner(det(the), _) --> [the].
determiner(det(a), s) --> [a].

noun(noun(pieplate), s) --> [pieplate].
noun(noun(pieplates), m) --> [pieplates].
noun(noun(surprise), s) --> [surprise] .
noun(noun(surprises), m) --> [surprises].

adjective(adj(decorated)) --> [decorated] .
verb(verb(contains), s) --> [contains].
verb(verb(contain), m) --> [contain].

test1:-
  phrase(
    sentence(sent(np(det(the), np2(adj(decorated), np2(noun(pieplate)))), vp(verb(contains), np(det(a), np2(noun(surprise)))))),
    R), R = [the, decorated, pieplate, contains, a, surprise].

test2:-
  phrase(sentence(R), [the, decorated, pieplate, contains, a, surprise]),
  R = sent(np(det(the), np2(adj(decorated), np2(noun(pieplate)))), vp(verb(contains), np(det(a), np2(noun(surprise))))).
