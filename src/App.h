#ifndef APP_H
#define APP_H

#include <QApplication>
#include <QFileOpenEvent>
    
#include <QDebug>
#include "loader.h"
#include "Window.h"



class App : public QApplication
{
	Q_OBJECT
public:
	explicit App(int& argc, char *argv[]) :	QApplication(argc, argv),m_window()
	{

		QSurfaceFormat format;
		format.setDepthBufferSize(24);
		QSurfaceFormat::setDefaultFormat(format);

		setApplicationName("3Dom");
		setApplicationVersion("0.1");
		setOrganizationName("Ohad");
		setOrganizationDomain("www.ohad.co");
	
		
        
        if (argc > 1)
            m_window.loadMeshFromFile(argv[1]);
        //else
        //    m_window.loadMeshFromFile(Loader::default3DmodelFilename());
        
		
        
        
		
	

	}

protected:


private:

	Window m_window;

};

#endif // APP_H
