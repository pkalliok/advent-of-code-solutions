
natn(6420).
natn(X) :- natn(Y), X is Y + 60060.

% Wolfram alpha says:
% {X mod 60 = 0, X mod 26 = 24, X mod 22 = 18, X mod 14 = 8}
% -> X = 60060 n + 6420, n e Z

ok(N) :-
	0 is N mod 2,
	0 is N mod 4,
	0 is N mod 6,
	0 is N mod 10,
	not(0 is N mod 8),
	8 is N mod 14,
	not(12 is N mod 16),
	not(0 is N mod 18),
	not(12 is N mod 18),
	18 is N mod 22,
	24 is N mod 26,
	not(4 is N mod 32),
	not(12 is N mod 34),
	not(22 is N mod 34).

solution(S) :-
	natn(S),
	ok(S).

