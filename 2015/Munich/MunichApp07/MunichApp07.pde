boolean debug = false;
color colorBack = color(16, 129, 154);
color colorGreen = color(126, 172, 8);
color colorWhite = color(255);
color colorBlack = color(0);

import TUIO.*;
TuioProcessing tuioClient;

import ddf.minim.*;
Minim minim;

ArrayList<Cell> cells;
Camera camera;
SoundManager soundManager;
PFont fontTitle1, fontTitle2, fontCell, fontMedium, fontMedium2, fontText;
PImage icell, icell2, loading, marca;
TextView textView;
TouchManager touchManager;
UI ui;


void setup() {
  size(1920, 1080);
  //size(1200, 600);
  /*
  fontTitle1 = createFont("MunichRe Light", 42, true);
   fontTitle2 = createFont("MunichRe Medium", 38, true);
   */
  fontCell = createFont("MunichRe Regular", 24, true);
  fontMedium = createFont("MunichRe Medium", 17, true);
  fontMedium2 = createFont("MunichRe Medium", 12, true);
  fontText = createFont("MunichRe Light", 16, true);
  icell = loadImage("data/cellOpt.png");
  icell2 = loadImage("data/cell2.png");
  loading = loadImage("data/loading.png");
  marca = loadImage("data/marca.png");

  camera = new Camera(width/2, height/2);
  ui = new UI("Configuracion", 20, 20, 300, 400);
  textView = new TextView();
  touchManager = new TouchManager();

  loadData();

  tuioClient  = new TuioProcessing(this);
  minim = new Minim(this);
  soundManager = new SoundManager();
}


void draw() {
  pushMatrix();
  camera.update();
  touchManager.update();
  background(colorBack);
  for (int i = 0; i < cells.size (); i++) {
    Cell cell = cells.get(i);
    cell.update();
    cell.show();
  }
  for (int i = 0; i < cells.size (); i++) {
    Cell cell = cells.get(i);
    cell.showText();
  }

  textView.update();
  popMatrix();

  /*
  pushStyle();
   textAlign(LEFT, TOP);
   fill(colorBlack);
   textFont(fontTitle1);
   text("MUNICH RE RADAR", 58, 60);
   textFont(fontTitle2);
   text("Innovación", 58, 108);
   popStyle();
   */
  image(marca, 56, 58);

  ui.update();

  if (debug) {
    if (frameCount%20 == 0) frame.setTitle(frameRate+"fps");
    touchManager.show();
    //text(frameRate, 20, height-20);
  }
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
    String nodeName = row.getString(1);
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
        Trend subTrend = new Trend(trend, trend.x, trend.y, 20-random(4), subName);
      }
    }
  }
  c1.textRotate = true;
  c1.init();
  c2.textRotate = true;
  c2.init();
  textView.createImages(c2);
}

