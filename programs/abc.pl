#!/usr/bin/swipl

abc(ABC) :- s(ABC-[]), !.

s(ABC-X) :- as(ABC-BC), bs(BC-C), cs(C-X).

as([a|ABC]-BC) :- as(ABC-BC).
as(BC-BC).

bs([b|BC]-C) :- bs(BC-C).
bs(C-C).

cs([c|C]-X) :- cs(C-X).
cs([]-[]).
