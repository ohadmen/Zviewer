
#ifndef CANVAS_H
#define CANVAS_H


#include <QMouseEvent>
#include <QOpenGLWidget>
#include <QOpenGLFunctions>
#include <QMatrix4x4>
#include <QQuaternion>
#include <QVector2D>
#include <QBasicTimer>
#include "loader.h"
#include "TrackUtils.h"
#include "Params.h"
#include "Qmvp.h"

class GeometryEngine;

class Canvas : public QOpenGLWidget, protected QOpenGLFunctions
{
	Q_OBJECT

public:
	explicit Canvas(QWidget *parent=0) :
		QOpenGLWidget(parent),
		m_currentMeshToken(-1),
		

		angularSpeed(0)
	{

	}
	~Canvas()
	{

		// and the buffers.
		makeCurrent();

		
		doneCurrent();
	}
	void setToken(int token) { 
		m_currentMeshToken = token;
		MeshArray::i().getMesh(m_currentMeshToken)->initGL();
	}
	void loadMesh(int token)
	{
		MeshArray::i().getMesh(token)->initGL();
	}
	bool cam2geometry()
	{
		static const float deg2rad = std::acos(0.0f) / 90.0f;

		Mesh* p = MeshArray::i().getMesh(m_currentMeshToken);
		if (p == nullptr)
			return false;
		m_mvp.resetView();

		float t = p->getContainmentRadius() / std::tan(Params::camFOV() / 2 * deg2rad);
		m_mvp.applyT(-p->getCenter() - QVector3D(0, 0, t));

	}
protected:
	void wheelEvent(QWheelEvent *event)
	{

		m_mvp.applyT(QVector3D(0, 0, float(event->delta()) / 1000));
		update();
		
	}
	void mousePressEvent(QMouseEvent *e)
	{
		// Save mouse press position
		mousePressPosition = QVector2D(e->localPos());
	}
	void mouseReleaseEvent(QMouseEvent *e)
	{
		// Mouse release position - mouse press position
		QVector2D diff = QVector2D(e->localPos()) - mousePressPosition;

		// Rotation axis is perpendicular to the mouse position difference
		// vector
		QVector3D n = QVector3D(diff.y(), diff.x(), 0.0).normalized();

		// Accelerate angular speed relative to the length of the mouse sweep
		qreal acc = diff.length() / 100.0;

		// Calculate new rotation axis as weighted sum
		rotationAxis = (rotationAxis * angularSpeed + n * acc).normalized();

		// Increase angular speed
		angularSpeed += acc;
	}
	void timerEvent(QTimerEvent *e) {
		// Decrease angular speed (friction)
		angularSpeed *= 0.99;

		// Stop rotation when speed goes below threshold
		if (angularSpeed < 0.01) {
			angularSpeed = 0.0;
		}
		else {
			// Update rotation
			rotation = QQuaternion::fromAxisAndAngle(rotationAxis, angularSpeed) * rotation;
			m_mvp.applyR(rotationAxis, angularSpeed);
			// Request an update
			update();
		}
	}
	
	void initializeGL()
	{
		initializeOpenGLFunctions();
		//glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glEnable(GL_BLEND);
		glEnable(GL_LINE_SMOOTH);
		glClearColor(0, 0, 0, 1);

		glEnable(GL_DEPTH_TEST);
		//
		glEnable(GL_CULL_FACE);

		
		m_trackUtils.init();
//		auto t = MeshArray::i().getTokenList();
//		for (auto zz : t)
//			MeshArray::i().getMesh(zz)->initGL();
		// Use QBasicTimer because its faster than QTimer
		timer.start(12, this);
	}

	void resizeGL(int w, int h)
	{
		// Calculate aspect ratio
		qreal aspect = qreal(w) / qreal(h ? h : 1);

		// Set near plane to 3.0, far plane to 7.0, field of view 45 degrees
		const qreal zNear = 1.0, zFar = 99.0, fov = 45.0;	


		m_mvp.setPerpective(aspect);

	
		
	}
	void paintGL()
	{
		// Clear color and depth buffer
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);



		// Calculate model view transformation
		QMatrix4x4 matrix;
		matrix.translate(0.0, 0.0, -5.0);
		matrix.rotate(rotation);

		// Set modelview-projection matrix
		QMatrix4x4 mvp = m_mvp.getPmat() * matrix;

		m_trackUtils.drawSphereIcon(m_mvp.getPmat() * matrix, false);


		Mesh* p = MeshArray::i().getMesh(m_currentMeshToken);
		if (p == nullptr)
			return;
		p->draw(mvp);
	}


private:
	QBasicTimer timer;
	
	

	

	
	QVector2D mousePressPosition;
	QVector3D rotationAxis;
	qreal angularSpeed;
	QQuaternion rotation;


	int m_currentMeshToken;
	
	TrackUtils m_trackUtils;
	Qmvp m_mvp;
};

#endif // Canvas_H
