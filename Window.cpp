#include <iostream>
#include "Window.h"

mWindow::mWindow(): 
	tableTerm(2, 2, true),
	hBoxTerm(),
	m_VBox(),
	bAnalize("Analize"),
	m_Label1("Termino:    "),
	m_Label2("Contents of tab 2"),
	m_Button_Quit("Quit")
{
	set_title("Proyecto CC307");
	set_border_width(10);
	set_size_request (450, 300);
	set_resizable (false);

	add(m_VBox);

	//Add the Notebook, with the button underneath:
	m_Notebook.set_border_width(10);
	m_VBox.pack_start(m_Notebook);

	m_Button_Quit.signal_clicked().connect(sigc::mem_fun(*this, &mWindow::on_button_quit) );
	m_Notebook.signal_switch_page().connect(sigc::mem_fun(*this, &mWindow::on_notebook_switch_page) );

	//vboxTerm
	hBoxTerm.set_border_width(10);
	hBoxTerm.pack_start(m_Label1, Gtk::PACK_SHRINK);
	hBoxTerm.pack_start(termEntry);

	//buttonBox
	buttonBox.set_layout(Gtk::BUTTONBOX_END);
	buttonBox.pack_start(bAnalize, Gtk::PACK_SHRINK);
	bAnalize.signal_clicked().connect(sigc::mem_fun(*this, &mWindow::onAnalizeButton) );
	m_VBox.pack_start(buttonBox, Gtk::PACK_SHRINK);
	m_VBox.set_spacing(6);

	//Add the Notebook pages:
	m_Notebook.append_page(hBoxTerm, "Termino");
	m_Notebook.append_page(m_Label2, "Formula");

	show_all_children();
}

mWindow::~mWindow()
{
}

void mWindow::on_button_quit()
{
	hide();
}

void mWindow::on_notebook_switch_page(Gtk::Widget* /* page */, guint page_num)
{
  //std::cout << "Switched to tab with index " << page_num << std::endl;
}

void mWindow::setPrologProgram(char *program){
	pl = new Prolog(program);
}

void mWindow::onAnalizeButton(){

	if(pl->consultProlog((const char *)"isTerm", 1, (const char *)"f(1,2)")){
		Gtk::MessageDialog dialog(*this, "Correcto");
		dialog.set_secondary_text("Si entro al hola");
		dialog.run();
		
	}
	else{
		Gtk::MessageDialog dialog(*this, "Error");
		dialog.set_secondary_text("no entro");
		dialog.run();
	}
	
}

