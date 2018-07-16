
% does not work.  Here just to save work in progress.

:- use_module(library(pio)).
:- use_module(library(ugraphs)).

map(Row, [Line|Lines]) -->
	mapline(Row, 0, Line),
	"\n",
	{ Next is Row + 1 },
	map(Next, Lines).
map(_, []) --> [].

mapline(Row, Col, [cell(Row, Col, Cell)|Cells]) -->
	cell(Cell),
	{ Next is Col + 1 },
	mapline(Row, Next, Cells).
mapline(_, _, []) --> [].

cell(used) --> "#".
cell(free) --> ".".

read_data(Map) :- phrase_from_file(map(0, Map), 'tmp/day14.txt').

cell_links(Mid, Left, Right, Up, Down, cell(Row,Col)-Links) :-
	Mid = cell(Row, Col, _),
	cell_links(Mid, Left, Right, Up, Down, Links, []).

cell_links(cell(_, _, used), Left, Right, Up, Down) --> 
	cell_link(Left),
	cell_link(Right),
	cell_link(Up),
	cell_link(Down).
cell_links(cell(_, _, free), _, _, _, _) --> [].

cell_link(cell(Row, Col, used)) --> [cell(Row,Col)].
cell_link(cell(_, _, free)) --> [].

mapdiff(

map_links(Map, Links) :- map_links([[]|Map], Links, []).

map_links(Map) -->
	{ Map = [Up | NextMap],
	  NextMap = [Mid, Down | Rest],
	  Mid = [Cell | Right],
	  Left = [cell(0,0,free) | Mid] },
	row_links(Mid, Left, Right, Up, Down),
	map_links(NextMap).
map_links(_) --> [].

solution(X) :- X = solution.

