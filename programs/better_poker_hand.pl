#!/usr/bin/swipl
% better poker hand function's realization
better_poker_hand(H1, H2, H) :-
  mergesort(H1, SH1),
  mergesort(H2, SH2), !,
  betterhand(SH1, SH2, H).
% Треф - t, Пики - p, Буби - b, Черви - h
test1 :-
  better_poker_hand([
    card(ace, h),
    card(king, h),
    card(queen, h),
    card(jack, h),
    card(10, h)
  ],[
    card(ace, t),
    card(king, t),
    card(queen, t),
    card(jack, t),
    card(10, t)
  ], []).
test2 :-
  better_poker_hand([
    card(ace, h),
    card(king, h),
    card(queen, h),
    card(jack, h),
    card(10, h)
  ],[
    card(king, t),
    card(10, t),
    card(ace, t),
    card(queen, t),
    card(jack, t)
  ], []).
test3 :-
  better_poker_hand([
    card(ace, h),
    card(king, h),
    card(queen, h),
    card(jack, h),
    card(10, h)
  ],[
    card(king, t),
    card(10, t),
    card(9, t),
    card(8, t),
    card(7, t)
  ], [
    card(ace, h),
    card(king, h),
    card(queen, h),
    card(jack, h),
    card(10, h)
  ]).
test4 :-
  better_poker_hand([
    card(ace, h),
    card(king, h),
    card(queen, h),
    card(jack, h),
    card(10, h)
  ],[
    card(king, t),
    card(10, f),
    card(9, t),
    card(8, t),
    card(7, t)
  ], [
    card(ace, h),
    card(king, h),
    card(queen, h),
    card(jack, h),
    card(10, h)
  ]).
test5 :-
  better_poker_hand([
    card(king, h),
    card(king, t),
    card(queen, h),
    card(queen, p),
    card(2, h)
  ],[
    card(king, p),
    card(king, b),
    card(9, t),
    card(8, t),
    card(7, t)
  ], [
    card(king, h),
    card(king, t),
    card(queen, h),
    card(queen, p),
    card(2, h)
  ]).
test6 :-
  better_poker_hand([
    card(queen, h),
    card(queen, t),
    card(4, h),
    card(7, p),
    card(2, h)
  ],[
    card(king, p),
    card(king, b),
    card(9, t),
    card(8, t),
    card(7, t)
  ], [
    card(king, p),
    card(king, b),
    card(9, t),
    card(8, t),
    card(7, t)
  ]).
test7 :-
  better_poker_hand([
    card(king, h),
    card(king, t),
    card(10, h),
    card(7, p),
    card(2, h)
  ],[
    card(king, p),
    card(king, b),
    card(9, t),
    card(8, t),
    card(7, t)
  ], [
    card(king, h),
    card(king, t),
    card(10, h),
    card(7, p),
    card(2, h)
  ]).

test8 :-
  better_poker_hand([
    card(king, h),
    card(king, t),
    card(10, h),
    card(7, p),
    card(2, h)
  ],[
    card(king, p),
    card(king, b),
    card(10, t),
    card(8, t),
    card(7, t)
  ], [
    card(king, p),
    card(king, b),
    card(10, t),
    card(8, t),
    card(7, t)
  ]).

test9 :-
  has_three_of_a_kind([
    card(ace, p),
    card(queen, b),
    card(queen, t),
    card(queen, h),
    card(7, t)
  ], 2).
test10 :-
  better_poker_hand([
    card(king, h),
    card(king, t),
    card(king, b),
    card(7, p),
    card(2, h)
  ],[
    card(ace, p),
    card(queen, b),
    card(queen, t),
    card(queen, h),
    card(7, t)
  ],[
    card(king, _),
    card(king, _),
    card(king, _),
    card(7, _),
    card(2, _)
  ]).
test11 :-
  better_poker_hand([
    card(king, h),
    card(king, t),
    card(queen, b),
    card(7, p),
    card(2, h)
  ],[
    card(ace, p),
    card(queen, b),
    card(queen, t),
    card(queen, h),
    card(7, t)
  ],[
    card(ace, p),
    card(queen, _),
    card(queen, _),
    card(queen, _),
    card(7, t)
  ]).


betterhand(H1, H2, H1) :-
  bettercombination(H1, C1),
  bettercombination(H2, C2),
  isbetter(C1, C2).

betterhand(H1, H2, H2) :-
  bettercombination(H1, C1),
  bettercombination(H2, C2),
  isbetter(C2, C1).

betterhand(H1, H2, H1) :-
  bettercombination(H1, C),
  bettercombination(H2, C),
  bettercards(H1, H2, C).

betterhand(H1, H2, H2) :-
  bettercombination(H1, C),
  bettercombination(H2, C),
  bettercards(H2, H1, C).

betterhand(H1, H2, []) :-
  bettercombination(H1, C),
  bettercombination(H2, C),
  not(bettercards(H1, H2, C)),
  not(bettercards(H2, H1, C)).

% bettercards [helper]
bettercards(H1, H2, straight_flush) :-
  getcardfromhand(H1, 1, C1),
  getcardfromhand(H2, 1, C2),
  isbettercard(C1, C2).

bettercards(H1, H2, four_of_a_kind) :-
  has_four_of_a_kind(H1, N1),
  has_four_of_a_kind(H2, N2),
  getcardfromhand(H1, N1, C1),
  getcardfromhand(H2, N2, C2),
  isbettercard(C1, C2).

bettercards(H1, H2, full_house) :-
  getcardfromhand(H1, 3, C13),
  getcardfromhand(H2, 3, C23),
  isbettercard(C13, C23).
bettercards(H1, H2, full_house) :-
  getcardfromhand(H1, 3, C13),
  getcardfromhand(H2, 3, C23),
  isequalcards(C23, C13),
  has_full_house(H1, N1),
  has_full_house(H2, N2),
  getcardfromhand(H1, N1, C12),
  getcardfromhand(H2, N2, C22),
  isbettercard(C12, C22).

bettercards(H1, H2, flush) :-
  getcardfromhand(H1, 1, C1),
  getcardfromhand(H2, 1, C2),
  isbetter(C1, C2).
bettercards(H1, H2, flush) :-
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, 2, C12),
  getcardfromhand(H2, 2, C22),
  isbettercard(C12, C22).
bettercards(H1, H2, flush) :-
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, 2, C12),
  getcardfromhand(H2, 2, C22),
  isequalcards(C12, C22),
  getcardfromhand(H1, 3, C13),
  getcardfromhand(H2, 3, C23),
  isbettercard(C13, C23).
bettercards(H1, H2, flush) :-
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, 2, C12),
  getcardfromhand(H2, 2, C22),
  isequalcards(C12, C22),
  getcardfromhand(H1, 3, C13),
  getcardfromhand(H2, 3, C23),
  isequalcards(C13, C23),
  getcardfromhand(H1, 4, C14),
  getcardfromhand(H2, 4, C24),
  isbettercard(C14, C24).
bettercards(H1, H2, flush) :-
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, 2, C12),
  getcardfromhand(H2, 2, C22),
  isequalcards(C12, C22),
  getcardfromhand(H1, 3, C13),
  getcardfromhand(H2, 3, C23),
  isequalcards(C13, C23),
  getcardfromhand(H1, 4, C14),
  getcardfromhand(H2, 4, C24),
  isequalcards(C14, C24),
  getcardfromhand(H1, 5, C15),
  getcardfromhand(H2, 5, C25),
  isbettercard(C15, C25).

bettercards(H1, H2, straight) :-
  getcardfromhand(H1, 1, C1),
  getcardfromhand(H2, 1, C2),
  isbettercard(C1, C2).

bettercards(H1, H2, three_of_a_kind) :-
  getcardfromhand(H1, 3, C1),
  getcardfromhand(H2, 3, C2),
  isbettercard(C1, C2).

bettercards(H1, H2, two_pair) :-
  has_two_pair(H1, N11, _, _),
  has_two_pair(H2, N21, _, _),
  getcardfromhand(H1, N11, C11),
  getcardfromhand(H2, N21, C21),
  isbettercard(C11, C21).
bettercards(H1, H2, two_pair) :-
  has_two_pair(H1, N11, N12, _),
  has_two_pair(H2, N21, N22, _),
  getcardfromhand(H1, N11, C11),
  getcardfromhand(H2, N21, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, N12, C12),
  getcardfromhand(H2, N22, C22),
  isbettercard(C12, C22).
bettercards(H1, H2, two_pair) :-
  has_two_pair(H1, N11, N12, N13),
  has_two_pair(H2, N21, N22, N23),
  getcardfromhand(H1, N11, C11),
  getcardfromhand(H2, N21, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, N12, C12),
  getcardfromhand(H2, N22, C22),
  isequalcards(C12, C22),
  getcardfromhand(H1, N13, C13),
  getcardfromhand(H2, N23, C23),
  isbettercard(C13, C23).

bettercards(H1, H2, one_pair) :-
  has_one_pair(H1, NV1),
  has_one_pair(H2, NV2),
  getcardfromhand(H1, NV1, CV1),
  getcardfromhand(H2, NV2, CV2),
  isbettercard(CV1, CV2).
bettercards(H1, H2, one_pair) :-
  has_one_pair(H1, NV1),
  has_one_pair(H2, NV2),
  getcardfromhand(H1, NV1, CV1),
  getcardfromhand(H2, NV2, CV2),
  isequalcards(CV1, CV2),
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isbettercard(C11, C21).
bettercards(H1, H2, one_pair) :-
  has_one_pair(H1, NV1),
  has_one_pair(H2, NV2),
  getcardfromhand(H1, NV1, CV1),
  getcardfromhand(H2, NV2, CV2),
  isequalcards(CV1, CV2),
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, 2, C12),
  getcardfromhand(H2, 2, C22),
  isbettercard(C12, C22).
bettercards(H1, H2, one_pair) :-
  has_one_pair(H1, NV1),
  has_one_pair(H2, NV2),
  getcardfromhand(H1, NV1, CV1),
  getcardfromhand(H2, NV2, CV2),
  isequalcards(CV1, CV2),
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, 2, C12),
  getcardfromhand(H2, 2, C22),
  isequalcards(C12, C22),
  getcardfromhand(H1, 3, C13),
  getcardfromhand(H2, 3, C23),
  isbettercard(C13, C23).
bettercards(H1, H2, one_pair) :-
  has_one_pair(H1, NV1),
  has_one_pair(H2, NV2),
  getcardfromhand(H1, NV1, CV1),
  getcardfromhand(H2, NV2, CV2),
  isequalcards(CV1, CV2),
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, 2, C12),
  getcardfromhand(H2, 2, C22),
  isequalcards(C12, C22),
  getcardfromhand(H1, 3, C13),
  getcardfromhand(H2, 3, C23),
  isequalcards(C13, C23),
  getcardfromhand(H1, 4, C14),
  getcardfromhand(H2, 4, C24),
  isbettercard(C14, C24).
bettercards(H1, H2, one_pair) :-
  has_one_pair(H1, NV1),
  has_one_pair(H2, NV2),
  getcardfromhand(H1, NV1, CV1),
  getcardfromhand(H2, NV2, CV2),
  isequalcards(CV1, CV2),
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, 2, C12),
  getcardfromhand(H2, 2, C22),
  isequalcards(C12, C22),
  getcardfromhand(H1, 3, C13),
  getcardfromhand(H2, 3, C23),
  isequalcards(C13, C23),
  getcardfromhand(H1, 4, C14),
  getcardfromhand(H2, 4, C24),
  isequalcards(C14, C24),
  getcardfromhand(H1, 5, C15),
  getcardfromhand(H2, 5, C25),
  isbettercard(C15, C25).

bettercards(H1, H2, high_card) :-
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isbettercard(C11, C21).
bettercards(H1, H2, high_card) :-
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, 2, C12),
  getcardfromhand(H2, 2, C22),
  isbettercard(C12, C22).
bettercards(H1, H2, high_card) :-
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, 2, C12),
  getcardfromhand(H2, 2, C22),
  isequalcards(C12, C22),
  getcardfromhand(H1, 3, C13),
  getcardfromhand(H2, 3, C23),
  isbettercard(C13, C23).
bettercards(H1, H2, high_card) :-
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, 2, C12),
  getcardfromhand(H2, 2, C22),
  isequalcards(C12, C22),
  getcardfromhand(H1, 3, C13),
  getcardfromhand(H2, 3, C23),
  isequalcards(C13, C23),
  getcardfromhand(H1, 4, C14),
  getcardfromhand(H2, 4, C24),
  isbettercard(C14, C24).
bettercards(H1, H2, high_card) :-
  getcardfromhand(H1, 1, C11),
  getcardfromhand(H2, 1, C21),
  isequalcards(C11, C21),
  getcardfromhand(H1, 2, C12),
  getcardfromhand(H2, 2, C22),
  isequalcards(C12, C22),
  getcardfromhand(H1, 3, C13),
  getcardfromhand(H2, 3, C23),
  isequalcards(C13, C23),
  getcardfromhand(H1, 4, C14),
  getcardfromhand(H2, 4, C24),
  successor(C14, C24),
  getcardfromhand(H1, 5, C15),
  getcardfromhand(H2, 5, C25),
  isbettercard(C15, C25).

% bettercombination [helper]
bettercombination(H, royal_flush) :-
  has_royal_flush(H).

bettercombination(H, straight_flush) :-
  has_straight_flush(H).

bettercombination(H, four_of_a_kind) :-
  has_four_of_a_kind(H, _).

bettercombination(H, full_house) :-
  has_full_house(H, _).

bettercombination(H, flush) :-
  has_flush(H).

bettercombination(H, straight) :-
  has_straight(H).

bettercombination(H, three_of_a_kind) :-
  has_three_of_a_kind(H, _).

bettercombination(H, two_pair) :-
  has_two_pair(H, _, _, _).

bettercombination(H, one_pair) :-
  has_one_pair(H, _).

bettercombination(H, high_card).

% has_%combination% [helpers]
% no number
has_royal_flush([
  card(ace, S),
  card(king, S),
  card(queen, S),
  card(jack, S),
  card(10, S)
]).

% no number
has_straight_flush([
  card(V1, S),
  card(V2, S),
  card(V3, S),
  card(V4, S),
  card(V5, S)
]) :-
  successor(V1, V2),
  successor(V2, V3),
  successor(V3, V4),
  successor(V4, V5).

% number is first card position of fours
has_four_of_a_kind([
  card(V, _),
  card(V, _),
  card(V, _),
  card(V, _),
  card(_, _)
], 1).
has_four_of_a_kind([
  card(_, _),
  card(V, _),
  card(V, _),
  card(V, _),
  card(V, _)
], 2).

% number is first card position of pair
has_full_house([
  card(V1, _),
  card(V1, _),
  card(V1, _),
  card(V2, _),
  card(V2, _)
], 4).
has_full_house([
  card(V1, _),
  card(V1, _),
  card(V2, _),
  card(V2, _),
  card(V2, _)
], 1).

% no number
has_flush([
  card(_, S),
  card(_, S),
  card(_, S),
  card(_, S),
  card(_, S)
]).

% no number
has_straight([
  card(V1, _),
  card(V2, _),
  card(V3, _),
  card(V4, _),
  card(V5, _)
]) :-
  successor(V1, V2),
  successor(V2, V3),
  successor(V3, V4),
  successor(V4, V5).

% number is first card of pair position
has_three_of_a_kind([
  card(V, _),
  card(V, _),
  card(V, _),
  card(_, _),
  card(_, _)
], 1).
has_three_of_a_kind([
  card(_, _),
  card(V, _),
  card(V, _),
  card(V, _),
  card(_, _)
], 2).
has_three_of_a_kind([
  card(_, _),
  card(_, _),
  card(V, _),
  card(V, _),
  card(V, _)
], 3).

% number is fullfilled position
has_two_pair([
  card(V1, _),
  card(V1, _),
  card(V2, _),
  card(V2, _),
  card(_, _)
], 1, 3, 5).
has_two_pair([
  card(V1, _),
  card(V1, _),
  card(_, _),
  card(V2, _),
  card(V2, _)
], 1, 4, 3).
has_two_pair([
  card(_, _),
  card(V1, _),
  card(V1, _),
  card(V2, _),
  card(V2, _)
], 2, 4, 1).

% number is first card of pair position
has_one_pair([
  card(V, _),
  card(V, _),
  card(_, _),
  card(_, _),
  card(_, _)
], 1).
has_one_pair([
  card(_, _),
  card(V, _),
  card(V, _),
  card(_, _),
  card(_, _)
], 2).
has_one_pair([
  card(_, _),
  card(_, _),
  card(V, _),
  card(V, _),
  card(_, _)
], 3).
has_one_pair([
  card(_, _),
  card(_, _),
  card(_, _),
  card(V, _),
  card(V, _)
], 4).

% get N-i card from hand
getcardfromhand([H|_], 1, H) :- iscard(H).
getcardfromhand([H], 1, H) :- iscard(H).
getcardfromhand([H|T], N, C) :-
  iscard(H),
  N > 1,
  N1 is N - 1,
  getcardfromhand(T, N1, C).

iscard(card(_, _)).

% is first combination/card better then second
isbettercard(card(V1, _), card(V2, _)) :-
  isbetter(V1, V2).

isbetter(C1, C2) :-
  successor(C1, C2).

isbetter(C1, C2) :-
  successor(C1, C),
  isbetter(C, C2).

isequalcards(card(V, _), card(V, _)).

successor(royal_flush, straight_flush).
successor(straight_flush, four_of_a_kind).
successor(four_of_a_kind, full_house).
successor(full_house, flush).
successor(flush, straight).
successor(straight, three_of_a_kind).
successor(three_of_a_kind, two_pair).
successor(two_pair, one_pair).
successor(one_pair, high_card).

successor(ace, king).
successor(king, queen).
successor(queen, jack).
successor(jack, 10).
successor(10, 9).
successor(9, 8).
successor(8, 7).
successor(7, 6).
successor(6, 5).
successor(5, 4).
successor(4, 3).
successor(3, 2).

% mergesort realization
mergesort([], []).
mergesort([H], [H]).
mergesort(L, SL) :-
  split(L, L1, L2),
  mergesort(L1, SL1),
  mergesort(L2, SL2),
  merge(SL1, SL2, SL).
% split [helper]
split([], _, _).
split([H|T], [H|L1], L2) :-
  split(T, L2, L1).
% merge [helper]
merge(L, [], L).
merge([], L, L).
merge([card(H1, M1)|T1], [card(H, M)|T2], [card(H, M)|T]) :-
  isbetter(H, H1), % H < H1
  merge([card(H1, M1)|T1], T2, T).
merge([card(H, M)|T1], [card(H1, M1)|T2], [card(H, M)|T]) :-
  not(isbetter(H1, H)), % H1 >= H
  merge(T1, [card(H1, M1)|T2], T).
