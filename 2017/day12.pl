
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

magnitude(List, M) :- sort(List, Unique), length(Unique, M).

clustersize_for_node(Closure, Node, Size) :-
	member(Node-Nodes, Closure),
	magnitude(Nodes, Size).

clusters([Node-Cluster|Clusters]) -->
	{ sort(Cluster, Unique) },
	[Unique],
	clusters(Clusters).
clusters([]) --> [].

unique_clusters(Closure, Number) :-
	clusters(Closure, Clusters, []),
	magnitude(Clusters, Number).

solution(S1, S2) :-
	load_data(Rules),
	transitive_closure(Rules, Closure),
	clustersize_for_node(Closure, '0', S1),
	unique_clusters(Closure, S2).

