#pragma once
#include "zview/backend/tree_model/tree_model.h"
#include "canvas.h"
#include <QtCore/QObject>
#include <QtWidgets/QTextBrowser>
#include <QtWidgets/QMainWindow>

class MainWindow : public QMainWindow
{
  Q_OBJECT
  
  void privloadFile();
  void privSavePly();
  void privShowHideAxes();
  void privShowHideGrid();
  void privSetTexture(int);

  void privAddMenuBar();
  
public slots:
  void slot_setStatus(const QString &str);

public:
  explicit MainWindow(QWidget *parent = 0);
  void takeScreenshot();
  void dropEvent(QDropEvent *event) override;
  void dragEnterEvent(QDragEnterEvent *event) override;
  void keyPressEvent(QKeyEvent *e) override;
  void keyReleaseEvent(QKeyEvent *e) override;
  void readFileList(const QStringList &files);

private:
  QTextBrowser m_status;
  Canvas *m_canvas;
  TreeModel* m_treeModel;
  const QString m_default_dir_key="default_dir";
};
