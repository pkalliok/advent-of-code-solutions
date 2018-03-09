
use_module(library(pio)).

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

read_line(Stream, Line) :- read_string(Stream, "\n", " ", 10, Line).

stream_lines(Stream, [Line|Lines]) :-
	read_line(Stream, Line),
	stream_lines(Stream, Lines).
stream_lines(_, []).

file_lines(File, Lines) :-
	open(File, read, Stream),
	stream_lines(Stream, Lines).

