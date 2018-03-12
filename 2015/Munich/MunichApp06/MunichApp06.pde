boolean debug = true;

import TUIO.*;
TuioProcessing tuioClient;

ArrayList<Cell> cells;
Camera camera;
PFont fontTitle, fontMedium, fontMedium2, fontText;
TextView textView;
TouchManager touchManager;
UI ui;

void setup() {
  size(1920, 1080);
  //size(1200, 640);

  fontTitle = createFont("MunichRe Regular", 24, true);
  fontMedium = createFont("MunichRe Medium", 15, true);
  fontMedium2 = createFont("MunichRe Medium", 10, true);
  fontText = createFont("MunichRe Light", 16, true);

  camera = new Camera(width/2, height/2);
  ui = new UI("Configuracion", 20, 20, 300, 400);
  touchManager = new TouchManager();
  textView = new TextView();

  loadData();

  tuioClient  = new TuioProcessing(this);
}


void draw() {
  pushMatrix();
  camera.update();
  touchManager.update();
  background(#10819A);
  for (int i = 0; i < cells.size (); i++) {
    Cell cell = cells.get(i);
    cell.update();
    cell.show();
    cell.showText();
  }
  textView.update();

  ui.update();

  if (debug) {
    if (frameCount%20 == 0) frame.setTitle(frameRate+"fps");
    touchManager.show();
  }
  popMatrix();
} 

void keyPressed() {
  if (key == 'l') {
    ui.load();
  } else if (key == 's') {
    ui.save();
  } else if (key == 'r') {
    loadData();
  } else if (key == 'h') {
    ui.hidden();
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
  cells = new ArrayList<Cell>();
  Table data = loadTable("data.csv", "csv"); 
  Cell c1 = new Cell(524, height/2, 192, "Business Trend Map"); 
  Cell c2 = new Cell(1304, height/2, 192, "IT Trend Map"); 
  //Cell c2 = new Cell(320, height/2, 192, "IT Trend Map"); 
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
        trend = new Trend(cell, 0, 0, 36, nodeName);
      }
      if (subName.equals("text")) {
        trend.text = row.getString(3).replace(";", "\n");
      } else {
        Trend subTrend = new Trend(trend, trend.x, trend.y, 20-random(4), subName.toUpperCase());
      }
    }
  }
  c1.init();
  c2.textRotate = true;
  c2.init();
}

