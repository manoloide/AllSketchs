boolean debug = false;
color colorBack = color(16, 129, 154);
color colorGreen = color(126, 172, 8);
color colorWhite = color(255);
color colorBlack = color(0);

import TUIO.*;
//TuioProcessing tuioClient;

import ddf.minim.*;
Minim minim;

ArrayList<Cell> cells;
Camera camera;
JSONObject jtouchs;
SoundManager soundManager;
PFont fontCell, fontMedium, fontMedium2, fontText, fontTitleText;
PImage icell, icell2, loading, marca, logo;
TextView textView;
TouchManager touchManager;
UI ui;


void setup() {
  size(1920, 1080, P2D);
  smooth(8);

  fontCell = createFont("Munich-Regular.otf", 24, true);
  fontMedium = createFont("Munich-Medium.otf", 17, true);
  fontMedium2 = createFont("Munich-Medium.otf", 12, true);

  fontTitleText = createFont("Munich-Medium.otf", 18, true);
  fontText = createFont("Munich-Light.otf", 16, true);

  icell = loadImage("data/cell.png");
  icell2 = loadImage("data/cell2.png");
  loading = loadImage("data/loading.png");
  marca = loadImage("data/marca.png");
  logo = loadImage("data/logoBlanco2.png");

  camera = new Camera(width/2, height/2);
  ui = new UI("Configuracion", 20, 20, 300, 400);
  textView = new TextView();
  touchManager = new TouchManager();

  loadJson();
  loadData();

  //tuioClient  = new TuioProcessing(this);
  minim = new Minim(this);
  soundManager = new SoundManager();
}


void draw() {
  pushMatrix();
  camera.update();
  touchManager.update();
  background(colorBack);
  textView.update();
  for (int i = 0; i < cells.size (); i++) {
    Cell cell = cells.get(i);
    cell.update();
    cell.showBack();
  }
  for (int i = 0; i < cells.size (); i++) {
    Cell cell = cells.get(i);
    cell.show();
  }
  for (int i = 0; i < cells.size (); i++) {
    Cell cell = cells.get(i);
    cell.showText();
  }

  textView.show();
  popMatrix();

  image(marca, 56, 58);
  imageMode(CORNERS);
  image(logo, width-logo.width-58, 58);//width-logo.width-60, height-logo.height-60);

  ui.update();

  if (debug) {
    if (frameCount%20 == 0) frame.setTitle(frameRate+"fps");
    touchManager.show();
    text(frameRate, 20, height-20);
  }
} 

void dispose() {
  saveJSONObject(jtouchs, "data/touchs.json");
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
  }else if (key == 'q') {
    saveImage();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
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
        trend.text = row.getString(3).replace(";", "\n").replace("-", "—");
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

void loadJson() {
  File f = new File(sketchPath("data/touchs.json"));
  if (f.exists()) {
    jtouchs = loadJSONObject("data/touchs.json");
  } else {
    jtouchs = new JSONObject();
    saveJSONObject(jtouchs, "data/touchs.json");
  }
}

void addJsonTouch(String name) {
  int aux = jtouchs.getInt(name, 0);
  jtouchs.setInt(name, aux+1);
}

