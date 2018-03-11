
:- use_module(library(pio)).
:- use_module(library(ugraphs)).

rules([R|Rs]) --> rule(R), "\n", rules(Rs).
rules([]) --> [].

rule(Lhs-Rhs) --> identifier(Lhs), ws, "<->", ws, identifiers(Rhs).

identifiers([Id|Ids]) --> identifier(Id), ws, ",", ws, identifiers(Ids).
identifiers([Id]) --> identifier(Id).

identifier(Id) --> word(Chars), { atom_codes(Id, Chars) }.

word([X|Xs]) --> [X], { char_type(X, alnum) }, word(Xs).
word([X]) --> [X], { char_type(X, alnum) }.

ws --> " ", ws.
ws --> [].

load_data(Rules) :-
	phrase_from_file(rules(Rules), 'tmp/day12.txt').

clustersize_for_node(Conns, Node, Size) :-
	transitive_closure(Conns, Closure),
	member(Node-Nodes, Closure),
	length(Nodes, Size).

solution(S) :-
	load_data(Rules),
	clustersize_for_node(Rules, '0', S).

