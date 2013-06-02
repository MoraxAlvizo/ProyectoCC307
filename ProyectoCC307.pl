:-op(500,xfy,->).
:-op(500,xfy,<->).
:-op(500,xfy,^).
:-op(500,xfy,v).
:-op(500,fx,¬).

variables([x,y,z,a,b,c,d,e,f,g]).
funtions([f/2, g/1, h/2, i/2]).
relations([w/2, v/1]).

isVar(X):-
	variables(L),
	member(X,L).
isCons(X):-
	integer(X);
	float(X).
isFunc(X):-
	funtions(F),
	functor(X,Name,Aridad),
	member(Name/Aridad,F)
	.

isTerm(X):- isVar(X).
isTerm(X):- isCons(X).
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
isTerm([]).
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
	  X = Z -> Y
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
	PPD = (X,Y),!
	.
primerParDiscordancia(X,Y,PPD):-
	functor(X,_,AridadX),
	functor(Y,_,AridadY),
	AridadX \= AridadY,
	PPD = (X,Y),!
	.
primerParDiscordancia(X,Y,PPD):-
	X =.. [_|ArgsX],
	Y =.. [_|ArgsY],
	ppdArgs(ArgsX,ArgsY,PPD),
	!
	.

ppdArgs([X|_],[Y|_], PPD):-
	primerParDiscordancia(X,Y, PPD)
	.
ppdArgs([_|XR],[_|YR], PPD):-
	ppdArgs(XR,YR, PPD)
	.

%primerParDiscordancia( p(a, f(a) )   , p( a, f(a) ) , PPD ).
replace(_,_,[],[]).
replace(Var,Value,[X|R],[F|Rest]):-
	functor(X,_,AridadX),
	AridadX > 0,
	X =.. [NameX|Args],!,
	replace(Var,Value,Args,Res),
	F =..[NameX|Res],!,
	replace(Var,Value,R, Rest)
	.
replace(Var, Value, [Var|R],[Value|Rest]):-
	!,replace(Var, Value, R,Rest)
	.
replace(Var, Value, [X|R],[X|Rest]):-
	!,replace(Var, Value, R,Rest)
	.

occursCheck(X,Y):-
	Y =..[_|Args],
	member(X,Args)
	.
occursCheck(X,Y):-
	Y =.. [_|Args],
	occursCheckArgs(X, Args)
	.
occursCheckArgs(_,[]):-fail.
occursCheckArgs(X,[H|_]):-
	functor(H,_,Aridad),
	Aridad > 0,
	occursCheck(X,H)
        .

occursCheckArgs(X,[_|R]):-
        occursCheckArgs(X,R)
	.

unifyRobinson(E, F, UMG):-
	initTerms(E, F),
	unifyRobinson(UMG)
	.
unifyRobinson([]):-
	b_getval(ek, EK),
	b_getval(fk, FK),
	write(EK),nl,
	write(FK),nl,
	EK == FK
	.
unifyRobinson([Sus|Rest]):-
	b_getval(ek, EK),
	b_getval(fk, FK),
	primerParDiscordancia(EK, FK, PPD),
	PPD = (Term1, Term2),
	(
	    (
	      isCons(Term1),
	      isCons(Term2),
	      !,fail
	    );
	    (
	     isVar(Term1) ,
	     isCons(Term2),!,
	     substitute(Term1, Term2, Sus),
	     unifyRobinson(Rest)
	    );
	    (
	     isVar(Term2) ,
	     isCons(Term1),!,
	     substitute(Term2, Term1, Sus),
	     unifyRobinson(Rest)
	    );
	    (
	     isVar(Term1) ,
	     isFunc(Term2),!,
	     not(occursCheck(Term1, Term2)),
	     substitute(Term1, Term2, Sus),
	     unifyRobinson(Rest)
	    );
	    (
	     isVar(Term2) ,
	     isFunc(Term1),!,
	     not(occursCheck(Term2, Term1)),
	     substitute(Term2, Term1, Sus),
	     unifyRobinson(Rest)
	    )

	)
	.

initTerms(E, F):-
	b_setval(ek, E),
	b_setval(fk, F)
	.


substitute(Var, Cons, Sus):-
	%get variables
	b_getval(ek, EK),
	b_getval(fk, FK),
	Sus = Var/Cons,
	EK =.. [HE|RE],
	replace(Var, Cons, RE, ResulE),
	EK1 =..[HE|ResulE],
	b_setval(ek, EK1),
	FK =.. [HF|RF],
	replace(Var, Cons, RF, ResulF),
	FK1 =..[HF|ResulF],
	b_setval(fk, FK1)
	.







