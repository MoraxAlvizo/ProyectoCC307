#include <stdio.h>
#include <gtk/gtk.h>
#include <SWI-Prolog.h>

#define MAXLINE 1024

static void destroy (GtkWidget*, gpointer);
static gboolean delete_event (GtkWidget*, GdkEvent*, gpointer);
static void switch_page (GtkButton*, GtkNotebook*);

int main (int argc, char *argv[])
{
	GtkWidget *window, *notebook, *vbox;
	GtkWidget *lTerm, *lFormula, *child1, *child2;

	char expression[MAXLINE];
	char *e = expression;
	char *program = argv[0];
	char *plav[2];
	int n;
	int rval;

	/* combine all the arguments in a single string */
	for(n=1; n<argc; n++)
	{ 
		if ( n != 1 )
		*e++ = ' ';
		strcpy(e, argv[n]);
		e += strlen(e);
	}

	/* make the argument vector for Prolog */

	plav[0] = program;
	plav[1] = NULL;

	/* initialise Prolog */

	if ( !PL_initialise(1, plav) )
		PL_halt(1);

	/* Lookup calc/1 and make the arguments and call */
	
	predicate_t pred = PL_predicate("hola", 1, "user");
	term_t h0 = PL_new_term_refs(1);

	PL_put_atom_chars(h0, expression);
	rval = PL_call_predicate(NULL, PL_Q_NORMAL, pred, h0);
	printf("%i",rval);
	PL_cleanup(rval ? 0 : 1);


	return 0;
}

/* Stop the GTK+ main loop function when the window is destroyed. */
static void destroy (GtkWidget *window, gpointer data)
{
	gtk_main_quit ();
}
/* Return FALSE to destroy the widget. By returning TRUE, you can cancel
* a delete-event. This can be used to confirm quitting the application. */
static gboolean delete_event (GtkWidget *window, GdkEvent *event, gpointer data)
{
	return FALSE;
}

/* Switch to the next or previous GtkNotebook page. */
static void switch_page (GtkButton *button, GtkNotebook *notebook)
{
	gint page = gtk_notebook_get_current_page (notebook);
	if (page == 0)
		gtk_notebook_set_current_page (notebook, 1);
	else
		gtk_notebook_set_current_page (notebook, 0);
}

