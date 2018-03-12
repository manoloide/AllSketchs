PImage img;
ArrayList puntos;

final int dis = 5;
final int dis2 = 20;
final int rango = 5;
//para la camara
import processing.video.*;
Capture cam;

void setup() {
  size(640, 480);
  frameRate(60);
  background(0);



  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, 640, 480);
  } if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, cameras[0]);
    // Or, the settings can be defined based on the text in the list
    //cam = new Capture(this, 640, 480, "Built-in iSight", 30);
    
    // Start capturing the images from the camera
    cam.start();
  } 

  puntos = new ArrayList();
  img = null;
  //println(width*height);
  //exit();
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    //image(cam, 0, 0);
    img = cam;
  }
  float x, y;
  color col;
  puntos = new ArrayList();
  for (int v = 0; v < 500;v++) {
    x = int(random(width));
    y = int(random(height-1));
    col = calcular(x, y);

    Punto aux1 = new Punto(x, y, col);
    puntos.add(aux1);

    for (int i = 0; i < puntos.size()-1;i++) {
      Punto aux2 = (Punto) puntos.get(i);
      if (dist(aux1.x, aux1.y, aux2.x, aux2.y)<=dis2) {
        stroke(aux2.col);
        line(aux1.x, aux1.y, aux2.x, aux2.y);
      }
    }
  }
}


color calcular(float cx, float cy) {
  if(img == null) return 0;
  color col;
  int lu = int(cy * img.width + cx);
  col = img.pixels[lu];
  col = color(red(col),green(col),blue(col),100);
  return col;
}

class Punto {
  float x, y;
  color col;

  Punto(float nx, float ny, color nc) {
    x = nx;
    y = ny;
    col = nc;
  }
}










void byn(float cx, float cy) {
  stroke(calcular(cx, cy));
  point(cx, cy);
}

void byn2() {
  for (int y = 0; y < img.height;y++) {
    for (int x = 0; x < img.width;x++) {
      stroke(calcular(x, y));
      point(x, y);
    }
  }
}
