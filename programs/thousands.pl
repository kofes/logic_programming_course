num(0) --> [zero].

num(N) --> num4(N).

num4(N) -->
  digit(D),
  [thousand],
  rest4(N1),
  {N is D * 1000 + N1}.
num4(N) -->
  tens(T),
  [ ],
  digit(D),
  [hundred],
  rest3(N1),
  {N is (T + D) * 100 + N1}.
num4(N) -->
  teen(T),
  [hundred],
  rest3(N1),
  {N is T * 100 + N1}.
num4(N) --> num3(N).

rest4(0) --> [ ].
rest4(N) --> num3(N).

num3(N) -->
  digit(D),
  [hundred],
  rest3(N1),
  {N is D*100+N1}.
num3(N) --> num2(N).

rest3(0) --> [ ].
rest3(N) --> [and], num2(N).

num2(N) --> digit(N).
num2(N) --> teen(N).
num2(N) -->
  tens(T),
  rest2(N1),
  {N is T+N1}.

rest2(0) --> [ ].
rest2(N) --> digit(N).

digit(1) --> [one].
digit(2) --> [two].
digit(3) --> [three].
digit(4) --> [four].
digit(5) --> [five].
digit(6) --> [six].
digit(7) --> [seven].
digit(8) --> [eight].
digit(9) --> [nine].

teen(10) --> [ten].
teen(11) --> [eleven].
teen(12) --> [twelve].
teen(13) --> [thirteen].
teen(14) --> [fourteen].
teen(15) --> [fifteen].
teen(16) --> [sixteen].
teen(17) --> [seventeen].
teen(18) --> [eighteen].
teen(19) --> [nineteen].

tens(20) --> [twenty].
tens(30) --> [thirty].
tens(40) --> [forty].
tens(50) --> [fifty].
tens(60) --> [sixty].
tens(70) --> [seventy].
tens(80) --> [eighty].
tens(90) --> [ninety].

test1:-
  phrase(num(1), R),
  R = [one].

test2:-
  phrase(num(10), R),
  R = [ten].

test3:-
  phrase(num(100), R),
  R = [one, hundred].

test4:-
  phrase(num(1000), R),
  (
    R = [one, thousand];
    R = [ten, hundred]
  ).

test5:-
  phrase(num(123), R),
  R = [one, hundred, and, twenty, three].

test6:-
  phrase(num(9999), R),
  (
    R = [nine, thousand, nine, hundred, and, ninety, nine];
    R = [ninety, nine, hundred, and, ninety, nine]
  ).
