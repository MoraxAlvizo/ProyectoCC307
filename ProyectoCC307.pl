:-op(500,xfy,->).
:-op(500,xfy,<->).
:-op(500,xfy,^).
:-op(500,xfy,v).
:-op(500,fx,¬).

variables([a,b,c,d,e,f,g]).
funtions([suma/2, resta/1, mult/2, div/2]).
relations([pow/2, raiz/1]).

isTerm(X):- variables(L),
	member(X,L)
        .
isTerm(X):-
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
	isTerm(X),!
	.

isFormula(X):-
	funtions(F),
	relations(R),
	functor(X,Name,Aridad),
	(
	    member(Name/Aridad,F);
	    member(Name/Aridad,R)
	),
	X =.. [_|Parameters],
	isTerm(Parameters),!
	.
isFormula(X):-
	(
	  X = Z ^ Y;
	X = Z v Y;
	  X = Z <-> Y;
	  X = Z ->  Y
	),
	isFormula(Z),
	isFormula(Y),
	!
	.
isFormula(X):-
	X = ¬Y,
	isFormula(Y)
	.

primerParDiscordancia(X,Y,PPD):-
	functor(X,NameX,_),
	functor(Y,NameY,_),
	NameX \= NameY,
	PPD = (X,Y)
	.
primerParDiscordancia(X,Y,PPD):-
	functor(X,_,AridadX),
	functor(Y,_,AridadY),
	AridadX \= AridadY,
	PPD = (X,Y)
	.
primerParDiscordancia(X,Y,PPD):-
	X =.. [_|ArgsX],
	Y =.. [_|ArgsY],
	ppdArgs(ArgsX,ArgsY,PPD)
	.

ppdArgs([X|_],[Y|_], PPD):-
	primerParDiscordancia(X,Y, PPD)
	.
ppdArgs([_|XR],[_|YR], PPD):-
	ppdArgs(XR,YR, PPD)
	.

%primerParDiscordancia( p(a, f(a) )   , p( a, f(a) ) , PPD ).
