boolean debug = false;

import TUIO.*;
TuioProcessing tuioClient;

ArrayList<Cell> cells;
TouchManager touchManager;

void setup() {
  size(1920, 1080);
  tuioClient  = new TuioProcessing(this);
  touchManager = new TouchManager();
  cells = new ArrayList<Cell>();
  loadData(); 
}


void draw() {
  touchManager.update();
  background(#10819A);
  for (int i = 0; i < cells.size (); i++) {
    cells.get(i).update();
  }

  if (debug) {
    if (frameCount%20 == 0) frame.setTitle(frameRate+"fps");
    touchManager.show();
  }
}

void mousePressed() {
  touchManager.addTouch(-1, mouseX, mouseY);
}

void mouseDragged() { 
  touchManager.updateTouch(-1, mouseX, mouseY);
}

void mouseReleased() {
  touchManager.removeTouch(-1);
}

void loadData() {
  Table data = loadTable("data.csv", "csv"); 
  Cell c1 = new Cell(524, height/2, "Business Trend Map"); 
  Cell c2 = new Cell(1304, height/2, "IT Trend Map"); 
  //Cell c2 = new Cell(width/2, height/2, "IT Trend Map"); 
  cells.add(c1);
  cells.add(c2);
  for (TableRow row : data.rows ()) {
    String cellName = row.getString(0);
    String nodeName = row.getString(1).toUpperCase();
    String subName = row.getString(2);
    Cell cell = null;
    if (cellName.equals("Business Trend Map")) {
      cell = c1;
    } else if (cellName.equals("IT Trend Map")) {
      cell = c2;
    }
    if (cell != null) {
      Trend trend = (Trend)cell.getNode(nodeName);
      if (trend == null) {
        trend = new Trend(cell, 0, 0, nodeName);
      }
      if (subName.equals("text")) {
        trend.text = row.getString(3).replace(";", "\n");
      } else {
        Trend subTrend = new Trend(trend, trend.x, trend.y, subName);
      }
    }
  }
  c1.init();
  c2.init();
}

