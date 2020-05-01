#include <QtWidgets/QApplication>
#include "QtCore/QStringList"
#include "zview/gui/main_window.h"

QStringList getArgs(int argc, char **argv)
{
    QStringList list;
    for (int i = 1; i != argc; ++i)
        list.push_back(argv[i]);
    
    return list;
}

int main(int argc, char **argv)
{
    
    QApplication app(argc, argv);
    auto list = getArgs(argc,argv);
    
    MainWindow win;
    win.readFileList(list);
    win.show();
    return app.exec();
}