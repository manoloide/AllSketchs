boolean debug = true;

import TUIO.*;
TuioProcessing tuioClient;

ArrayList<Cell> cells;
TouchManager touchManager;

void setup() {
  size(960, 640);
  touchManager = new TouchManager();
  cells = new ArrayList<Cell>();
  loadData(); 
  tuioClient  = new TuioProcessing(this);
}


void draw() {
  touchManager.update();
  background(#10819A);
  for (int i = 0; i < cells.size (); i++) {
    cells.get(i).update();
  }

  if (debug) {
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
  //Cell c1 = new Cell(320, height/2, "Business Trend Map"); 
  Cell c2 = new Cell(320, height/2, "IT Trend Map"); 
  cells.add(c2);
  for (TableRow row : data.rows ()) {
    String cellName = row.getString(0);
    String nodeName = row.getString(1).toUpperCase();
    String subName = row.getString(2);
    //para cuando tenga los dos nodos
    Cell cell = c2;
    if (cellName.equals("IT Trend Map")) {
      Node node = cell.getNode(nodeName);
      if (node == null) {
        node = new Node(0, 0, nodeName);
        cell.addNode(node);
      }
      if (subName.equals("text")) {
        node.text = row.getString(3).replace(";", "\n");
      } else {
      }
    }
  }
  c2.init();
}

