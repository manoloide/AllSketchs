/*
 +agrega toggle size to zoom
 +agregar color a los trazos
 +añadir optimizacion dibujjar todo en un pgraphics cada ves que se altera el canvas
 +layer
 +layer propierties
 *simetric points
 */

import codeanticode.tablet.*;

Tablet tablet;

ArrayList<Trazo> trazos;
boolean click, ctrl;
Camera camera;
Gui gui;
Trazo actualTrazo;

JSONObject json;

float minSize = 0.5; 
float maxSize = 2;
float smoothing = 0;
float taperTips = 0;
float jitter = 0;
float jitterVelocity = 0;
boolean sizeZoom = true;

void setup() {
  size(800, 600);
  tablet = new Tablet(this); 
  trazos = new ArrayList<Trazo>();
  camera = new Camera();
  gui = new Gui();

  if ((new File(sketchPath("save.json")).exists())) {
    json = loadJSONObject("save.json");
    JSONArray jtrazos = json.getJSONArray("trazos");
    for (int i = 0; i < jtrazos.size (); i++) {
      JSONArray jtrazo = jtrazos.getJSONArray(i);
      Trazo t = new Trazo();
      t.setJSON(jtrazo);
      trazos.add(t);
    }
  } else {
    json = new JSONObject();
  }
}

void draw() {
  background(252);
  pushMatrix();
  camera.update();
  if (mousePressed) {
    if (mouseButton == LEFT) {
      /*
      if (actualTrazo == null) {
       actualTrazo = new Trazo();
       trazos.add(actualTrazo);
       } else {
       float xx = mouseX/camera.scale-camera.x;
       float yy = mouseY/camera.scale-camera.y;
       actualTrazo.add(new Point(xx, yy, tablet.getPressure()));
       }
       */
    } else if (mouseButton == CENTER) {
      camera.x -= (pmouseX-mouseX)/camera.scale; 
      camera.y -= (pmouseY-mouseY)/camera.scale;
    } else if (mouseButton == RIGHT) {
      camera.zoom((pmouseX-mouseX)/40.);
    }
  }
  if (!mousePressed) {
    actualTrazo = null;
  }

  for (int i = 0; i < trazos.size (); i++) {
    Trazo t = trazos.get(i);
    t.show();
  }
  popMatrix();

  gui.update();
}

void dispose() {
  JSONArray jtrazos = new JSONArray();
  for (int i = 0; i < trazos.size (); i++) {
    Trazo t = trazos.get(i);
    jtrazos.setJSONArray(i, t.getJSON());
  }
  json.setJSONArray("trazos", jtrazos);
  saveJSONObject(json, "save.json");
}

void keyPressed() {
  if (keyCode == CONTROL && !ctrl) ctrl = true;
  if (ctrl && char(keyCode) == 'Z') {
    trazos.remove(trazos.size()-1);
  }
}

void keyReleased() {
  if (keyCode == CONTROL) ctrl = false;
} 

void mousePressed() {
  if (!click) click = true;
}

void mouseReleased() {
  click = false;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  camera.zoom(e);
}

class Camera {
  float x, y, z;
  float scale;
  Camera() {
    x = y = 0;
    z = 0;
    scale = pow(2, z);
  }
  void update() {
    scale(scale);
    translate(x, y);
  }
  void zoom(float e) {
    float ascale = scale;
    z -= e;
    scale = pow(2, z);
    x -= map(mouseX, 0, width, 0, width/ascale-width/scale);
    y -= map(mouseY, 0, height, 0, height/ascale-height/scale);
  }
}

class Point {
  float x, y, z;
  Point(float x, float y) {
    this.x = x; 
    this.y = y;
  }
  Point(float x, float y, float z) {
    this.x = x; 
    this.y = y; 
    this.z = z;
  }
  JSONObject getJSON() {
    JSONObject aux = new JSONObject();
    aux.setFloat("x", x);
    aux.setFloat("y", y);
    aux.setFloat("z", z);
    return aux;
  }
  void setJSON(JSONObject jo) {
    x = jo.getFloat("x");
    y = jo.getFloat("y");
    z = jo.getFloat("z");
  }
}

class Trazo {
  ArrayList<Point> points; 
  Trazo() {
    points = new ArrayList<Point>();
  }
  void add(Point p) {
    if (points.size() == 0) {
      points.add(p); 
      return;
    }
    Point ant = points.get(points.size()-1);
    if (ant.x != p.x || ant.y != p.y) {
      points.add(p);
    }
  }
  void show() {
    if (points.size() < 2) return;
    beginShape();
    noStroke();
    fill(0);
    /*
    noFill();
     stroke(0);
     */
    Point p = points.get(0);
    vertex(p.x, p.y);
    for (int i = 1; i < points.size ()-1; i++) {
      Point ant = points.get(i-1);
      Point sig = points.get(i+1);
      p = points.get(i);
      float a1 = atan2(ant.y-p.y, ant.x-p.x);
      float a2 = atan2(p.y-sig.y, p.x-sig.x);
      float aa = a2;
      a2 = max(a1, a2);
      a1 = min(a1, aa);
      float a = (a1+(a1-a2)/2)+HALF_PI;
      a = a1+HALF_PI;
      float d = map(p.z, 0, 1, minSize, maxSize);
      float x = p.x-cos(a)*d+(noise(frameCount*jitterVelocity+p.x+p.y)*2-1)*jitter;
      float y = p.y-sin(a)*d+(noise(frameCount*jitterVelocity+3+p.x+p.y)*2-1)*jitter;
      vertex(x, y);
    }
    p = points.get(points.size ()-1);
    vertex(p.x, p.y);
    for (int i = 1; i < points.size ()-1; i++) {
      Point ant = points.get(points.size()-i-1-1);
      Point sig = points.get(points.size()-i-1+1);
      p = points.get(points.size()-i-1);
      float a1 = atan2(ant.y-p.y, ant.x-p.x);
      float a2 = atan2(p.y-sig.y, p.x-sig.x);
      float aa = a2;
      a2 = max(a1, a2);
      a1 = min(a1, aa);
      float a = (a1+(a1-a2)/2)-HALF_PI;
      a = a1-HALF_PI;
      float d = map(p.z, 0, 1, minSize, maxSize);
      float x = p.x-cos(a)*d+(noise(frameCount*jitterVelocity+p.x+p.y)*2-1)*jitter;
      float y = p.y-sin(a)*d+(noise(frameCount*jitterVelocity+3+p.x+p.y)*2-1)*jitter;
      vertex(x, y);
    }
    endShape(CLOSE);
  }

  JSONArray getJSON() {
    JSONArray aux = new JSONArray();
    for (int i = 0; i < points.size (); i++) {
      Point p = points.get(i);
      JSONObject ja = new JSONObject();
      ja = p.getJSON();
      aux.setJSONObject(i, ja);
    }
    return aux;
  }
  void setJSON(JSONArray jo) {
    points = new ArrayList<Point>();
    for (int i = 0; i < jo.size (); i++) {
      JSONObject ja = jo.getJSONObject(i);
      Point p = new Point(ja.getFloat("x"), ja.getFloat("y"), ja.getFloat("z"));
      points.add(p);
    }
  }
}

