:-op(500,xfy,->).
:-op(500,xfy,<->).
:-op(500,xfy,^).
:-op(500,xfy,v).


funtions([suma/2, resta/1, mult/2, div/2]).
relations([pow/2, raiz/1]).

isTerm(X):- var(X).
isTerm(X):-
	atom(X);
	integer(X);
	float(X)
	.
isTerm(X):-
	funtions(F),
	relations(R),
	functor(X,Name,Aridad),
	(
	    member(Name/Aridad,F);
	    member(Name/Aridad,R)
	),
	X =.. [_|Parameters],
	isTerm(Parameters)
	.
isTerm([X|R]):-
	isTerm(X),
	isTerm(R)
	.

isFormula(X):-
	(   X = Z ^ Y;
	X = Z v Y;
	X = Z <-> Y),
	write(Z),
	write(Y)

	.














































































