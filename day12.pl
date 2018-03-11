
:- dynamic(link/2).
:- dynamic(indirect_link_dynamic/2).

:- use_module(library(pio)).

rules([R|Rs]) --> rule(R), "\n", rules(Rs).
rules([]) --> [].

rule(rule(Lhs, Rhs)) --> identifier(Lhs), ws, "<->", ws, identifiers(Rhs).

identifiers([Id|Ids]) --> identifier(Id), ws, ",", ws, identifiers(Ids).
identifiers([Id]) --> identifier(Id).

identifier(Id) --> word(Chars), { atom_codes(Id, Chars) }.

word([X|Xs]) --> [X], { char_type(X, alnum) }, word(Xs).
word([X]) --> [X], { char_type(X, alnum) }.

ws --> " ", ws.
ws --> [].

load_data(Rules) :-
	phrase_from_file(rules(Rules), 'tmp/day12.txt').

linearise_rule(rule(Lhs, [Rhs|Rest])) -->
	[link(Lhs, Rhs)],
	linearise_rule(rule(Lhs, Rest)).
linearise_rule(rule(Lhs, [Rhs])) --> [link(Lhs, Rhs)].

linearise_rules([Rule|Rules]) --> linearise_rule(Rule), linearise_rules(Rules).
linearise_rules([]) --> [].

initialise_data :-
	load_data(Rules),
	linearise_rules(Rules, Links, []),
	maplist(assertz, Links).

indirect_link(Init, Dest) :- indirect_link(Init, Init, Dest).
indirect_link(Init, _, Y) :- indirect_link_dynamic(Init, Y), !.
indirect_link(Init, X, X) :- assertz(indirect_link_dynamic(Init, X)).
indirect_link(Init, X, Y) :-
	link(X, Intermediate),
	indirect_link(Init, Intermediate, Y).

