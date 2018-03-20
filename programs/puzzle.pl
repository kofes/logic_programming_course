#!/usr/bin/swipl

:- use_module(library(clpfd)).

multiply([P, I] * [R] * [R] = [A, R, E, A]) :-
  Vs = [A, E, P, R, I],
  Vs ins 0..9,
  all_different(Vs),
  R * R * I + R * R * P * 10 #=
  A * 1000 + R * 100 + E * 10 + A,
  label(Vs).

multiply([B, I, G] * [B, E, N] = [L, O, N, D, O, N]) :-
  Vs = [B, D, E, G, I, N, L, O],
  Vs ins 0..9,
  all_different(Vs),
  G * N + G * E * 10 + G * B * 100 +
  (I * N + I * E * 10 + I * B * 100) * 10 +
  (B * N + B * E * 10 + B * B * 100) * 100 #=
  N + 10*(O + 10 * (D + 10 * (N + 10 * (O + 10 * L)))),
  label(Vs).
