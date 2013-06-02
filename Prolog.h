#ifndef PROLOG_H
#define PROLOG_H

#include <iostream>
#include <SWI-Prolog.h>

class Prolog
{
	public:
		Prolog(char *);
		virtual ~Prolog();
		bool consultProlog(const char *, int , char *);

	protected:
		char *program;
		char *plav[2];
		
};

#endif //GTKMM_EXAMPLEWINDOW_H
