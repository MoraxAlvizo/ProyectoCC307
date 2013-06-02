#ifndef GTKMM_EXAMPLEWINDOW_H
#define GTKMM_EXAMPLEWINDOW_H

#include <gtkmm.h>
#include "Prolog.h"

class mWindow : public Gtk::Window
{
	public:
		mWindow();
		virtual ~mWindow();

		void setPrologProgram(char *);

	protected:
		//Signal handlers:
		void on_button_quit();
		void on_notebook_switch_page(Gtk::Widget* page, guint page_num);

		Prolog *pl;

		//Child widgets:
		Gtk::Table tableTerm;
		Gtk::HBox hBoxTerm;
		Gtk::VBox m_VBox;
		Gtk::HButtonBox buttonBox;
		Gtk::Button bAnalize;
		Gtk::Notebook m_Notebook;
		Gtk::Label m_Label1, m_Label2;
		Gtk::Button m_Button_Quit;
		Gtk::Entry termEntry;

		void onAnalizeButton();
};

#endif //GTKMM_EXAMPLEWINDOW_H
