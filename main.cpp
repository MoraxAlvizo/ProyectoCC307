#include "Window.h"

int main(int argc, char *argv[])
{

    Gtk::Main kit(argc, argv);
    mWindow simple;
	simple.setPrologProgram(argv[0]);
    kit.run(simple);
    return 0;

}
