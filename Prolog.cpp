#include "Prolog.h"

Prolog::Prolog(char * program){


	this->program = program;
	plav[0] = program;
	plav[1] = NULL;

	/* initialise Prolog */

	if ( !PL_initialise(1, plav) )
		PL_halt(1);	

}

Prolog::~Prolog(){

}

bool Prolog::consultProlog(const char *predicado, int aridad, char* expression){

	int rval;

	/* Lookup calc/1 and make the arguments and call */
	predicate_t pred = PL_predicate(predicado, aridad, "user");
	term_t h0 = PL_new_term_refs(1);

	PL_put_atom_chars(h0, expression);
	rval = PL_call_predicate(NULL, PL_Q_NORMAL, pred, h0);
	PL_cleanup(rval ? 0 : 1);
	std::cout << rval << std::endl;
	return rval;

}



