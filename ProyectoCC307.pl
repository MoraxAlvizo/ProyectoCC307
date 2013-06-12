%	Proyecto Final Programación Logica y Funcional
%	Jose Omar Alvizo Flores
%	Maestra: Nancy Arana

:-op(500,xfy,->).
:-op(500,xfy,<->).
:-op(500,xfy,^).
:-op(500,xfy,v).
:-op(500,fx,¬).

variables([x,y,z,a,b,c,d,e]).
funtions([f/2, g/1, h/2, i/2]).
relations([w/2, k/1]).

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
	isTerm(E),
	isTerm(F),
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

unifyRobinson([EK/FK]):-
	b_getval(ek, EK),
	b_getval(fk, FK),
	isVar(EK),
	not(occursCheck(EK, FK))
	.

unifyRobinson([FK/EK]):-
	b_getval(ek, EK),
	b_getval(fk, FK),
	isVar(FK),
	not(occursCheck(FK, EK))
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
	     isVar(Term1) ,
	     isVar(Term2),!,
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

validateHH([X]):- X = 0.
validateHH([X|R]):-
	X = 0,
	validateHH(R)
	.
validateHH([X|_]):-
	X < 0,
	!,fail	.

validateList([]).
validateList([X]):-
	X >= 0.
validateList([X|R]):-
	X >= 0,
	validateList(R)
	.

% divide( +Piv, +Lista, -LMenores, -LMayores )
divide( _, [], [], [] ).
divide( P, [X|R], [X|Men], May ) :-
  X >= P,!,
  divide( P, R, Men, May ).
divide( P, [X|R], Men, [X|May] ) :-
  divide( P, R, Men, May ).

% quicksort( +Lista, -ListaOrd )
quicksort( [], [] ).
quicksort( [X], [X] ).
quicksort( [X|R], Res ) :-
  divide( X, R, Men, May ),
  quicksort( Men, MenOrd ),
  quicksort( May, MayOrd ),
  append( MenOrd, [X|MayOrd], Res ).

havelHakimi([X|R]):-write([X|R]),nl,
		    validateHH([X|R]).
havelHakimi([X|R]):-quicksort([X|R], LOrd),
    LOrd = [H|Rest],
    rest(H, Rest, LNva),!,
    validateList(LNva),!,
    havelHakimi(LNva)
    .

rest(0,R,R).
rest(N, [X|H], [Y|Rest]):-
	Y is X - 1,
	N1 is N - 1,
	rest(N1, H, Rest)
	.

% miembro( +Elemento, +Lista )
% ?- miembro( 3, [a,b,c] ). --> no
% ?- miembro( c, [a,b,c] ). --> yes
miembro( X, [X|_] ).
miembro( X, [_|R] ) :-
  miembro(X, R).

% concatena( +Lista1, +Lista2, -Lista12 )
% ?- concatena( [a,b,c], [d,e], L ). -->
% L = [a,b,c,d,e].
concatena( [], L, L ).
concatena( [X|R], Lista2, [X|Temp] ) :-
	concatena( R, Lista2, Temp ).

/*

1. selecciona( -Elem, +Lista, -Resto )
?- selecciona( X, [a,b,c], R ).
X = a, R = [b,c]
X = b, R = [a,c]
X = c, R = [a,b]
*/
selecciona(X, [X|R], R).
selecciona(X, [Cabeza|R],[Cabeza|Temp]):-
	selecciona(X,R,Temp)
.


/*
2. elimina( +Elem, +Lista, -Res )
?- elimina( 3, [a,b,3,c,d,3], R ).
R = [a,b,c,d,3]
*/

elimina(X, [X|R], R).
elimina(X, [Cabeza|R],[Cabeza|Temp]):-
	elimina(X,R,Temp)
.


/*
3. eliminaTodos( +Elem, +Lista, -Res )
?- eliminaTodos( 3, [a,b,3,c,d,3], R ).
R = [a,b,c,d]
*/
eliminaTodos(X, Lista, R):-
	not( selecciona(X,Lista,_)),
	Lista = R
.
eliminaTodos(X, Lista, R):-
	selecciona(X,Lista,Temp),
	eliminaTodos(X, Temp, R)
.


/*
4. cambiar( +Elem, +NvoElem, +Lista, -Res)
?- cambiar( x, 3, [a,b,x,c,x,d], R ).
R = [a,b,3,c,x,d]
*/

cambiar(X, Nvo, [X|R], [Nvo|R]).
cambiar(X, Nvo, [Cabeza|R], [Cabeza|Temp]):-
	cambiar(X, Nvo, R, Temp)
.

/*
5. cambiarTodos( +Elem, +NvoElem, +Lista, -Res)
?- cambiarTodos( x, 3, [a,b,x,c,x,d], R ).
R = [a,b,3,c,3,d]
*/

cambiarTodos(X, _, Lista, R):-
	not( selecciona(X,Lista,_)),
	Lista = R
.
cambiarTodos(X, Nvo, Lista, Resto):-
	cambiar(X,Nvo, Lista, Temp),
	cambiarTodos(X,Nvo, Temp,Resto)
.


/*
6. enesimo( +Indice, +Lista, -Elem )
?- enesimo( 3, [a,b,c,d], R ).
R = c
*/

enesimo(1,[X|_],X).
enesimo(Indice, [_|R], Elem):-
	X is Indice - 1,
	enesimo(X,R,Elem)
.


/*
7. eliminaEnesimo( +Indice, +Lista, -NLista )
?- eliminaEnesimo( 3, [a,b,c,d], R ).
R = [a,b,d]
*/

eliminaEnesimo(1,[_|R],R).
eliminaEnesimo(Indice, [X|R], [X|Temp]):-
	I is Indice - 1,
	eliminaEnesimo(I,R,Temp)
.
/*
8. insertaEnesimo( +Indice, +Elem, +Lista, -NLista)
?- insertaEnesimo( 3, x, [a,b,c,d], R ).
R = [a,b,x,c,d]
*/

insertarEnesimo(1,Elem,Lista,[Elem|Lista]).
insertarEnesimo(Indice,Elem, [X|R], [X|Temp]):-
	I is Indice - 1,
	insertarEnesimo(I,Elem,R,Temp)
.

/*
9. cambiaEnesimo( +Indice, +Elem, +Lista, -NLista )
?- cambiaEnesimo( 3, x, [a,b,c,d], R ).
R = [a,b,x,d]
*/

cambiarEnesimo(1,Elem,[_|Lista],[Elem|Lista]).
cambiarEnesimo(Indice,Elem, [X|R], [X|Temp]):-
	I is Indice - 1,
	cambiarEnesimo(I,Elem,R,Temp)
.

/*
10. longitud( +Lista, -N )
?- longitud( [a,b,c], R ).
R = 3
*/

longitud(0,[]).
longitud(L,[_|R]):-
	longitud(X,R),
	L is X+1
.



/*
11. sumatoria( +Lista, -S ).
?- sumatoria( [ 3,8,2], R ).
R = 13
*/

sumatoria([],0).
sumatoria([X|R],S):-
	sumatoria(R,Temp),
	S is Temp + X
.

/*
12. unionConj( +Conj1, +Conj2, -R )
?- unionConj( [a,b,c,d], [x,b,y,c], R ).
R = [a,b,c,d,x,y]
*/

eliminaRepetidos( [X|R] ,Lista , U) :-
	eliminaTodos(X, Lista, Temp),
	eliminaRepetidos(R, Temp, U)

.
eliminaRepetidos([],L,L).

unionConj( L1, L2, R ):-
	eliminaRepetidos(L1, L2, Temp),
	concatena(L1,Temp, R)

.
/*
13. intersConj( +Conj1, +Conj2, -R )
?- intersConj( [a,b,c,d], [x,b,y,c], R ).
R = [b,c]

*/

noRepetidos([],_).
noRepetidos([X|R],L2):-
	not(miembro(X,L2)),
	noRepetidos(R,L2)
.

intersConj(L1, L2, Lista):-
	noRepetidos(L1,L2),
	Lista = []
.

intersConj(L1, L2, [X|Lista]):-
	selecciona(X,L1,Temp),
	selecciona(X,L2,Temp2),
	intersConj(Temp,Temp2,Lista)
.
