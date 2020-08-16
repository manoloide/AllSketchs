Camera camera;
PGraphics gra;
PImage tiles;

void setup() {
  size(800, 800);
  camera = new Camera();
  frame.setResizable(true);
  tiles = loadImage("../data_noozh/tiles.png");
  generate();
}

void draw() {
  background(120);
  pushMatrix();
  camera.update();

  image(gra, 0, 0);
  popMatrix();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  camera.zoom(e);
}

void generate() {
  int w = 3508;
  int h = 4961;
  gra = createGraphics(w, h);
  gra.beginDraw();
  gra.background(#000000);
  gra.noSmooth();
  //gra.image(tiles, 0, 0, tiles.width*2, tiles.height*2);
  int cwt = tiles.width/16;
  int cht = tiles.height/16;
  for (int i = 0; i < 100000; i++) {
    int sca = int(pow(2, int(random(0, 6*random(1)))))*16;
    int x = int(random(w));
    int y = int(random(h));
    x -= x%sca;
    y -= y%sca;
    gra.image(getTile(tiles, int(random(cwt)), int(random(cht))), x, y, sca, sca);
  }
  /*
  gra.smooth();
   int sep = int(random(8, 20));
   gra.stroke(255, 20);
   for (int i = int (random (-sep)); i < w+h; i+=sep) {
   gra.line(-2, i, i, -2);
   }
   for (int i = 0; i < 10; i++) {
   float tt = 200+i*400;
   gra.fill(255, 10);
   gra.stroke(255, 26);
   gra.ellipse(w/2, h/2, tt, tt);
   int cc = int(random(4));
   for (int j = 0; j < cc; j++) {
   float a = random(TWO_PI);
   float xx = w/2+cos(a)*tt/2;
   float yy = h/2+sin(a)*tt/2;
   gra.fill(255, 10);
   gra.stroke(255, 26);
   gra.ellipse(xx, yy, tt*0.1, tt*0.1);
   gra.fill(255, 100);
   gra.stroke(255, 120);
   gra.ellipse(xx, yy, tt*0.01, tt*0.01);
   }
   }
   for (int i = 0; i < 20000; i++) {
   float a = random(TWO_PI);
   float d = pow(height/2, random(2));
   float x = w/2+cos(a)*d;
   float y = h/2+sin(a)*d;
   float t = random(1, 14);
   float t2 = t*random(1.2, 2);
   gra.pushMatrix();
   gra.translate(x, y);
   gra.rotate(random(TWO_PI));
   gra.noFill();
   gra.stroke(255, 4);
   for (int j = int (random (8, 16)); j >= 1; j--) {
   gra.strokeWeight(j);
   gra.ellipse(0, 0, t2, t);
   }
   gra.noStroke();
   if (random(1) < 0.8)
   gra.fill(255);
   else {
   if (random(1) < 0.333) {
   gra.fill(255, 255, 0);
   } else if (random(1) < 0.5) {
   gra.fill(255, 0, 255);
   } else {
   gra.fill(0, 255, 255);
   }
   }
   gra.ellipse(0, 0, t2, t);
   gra.popMatrix();
   }
   */
  gra.endDraw();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  gra.save(timestamp+".png");
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
    if (mousePressed) {
      if (mouseButton == LEFT) {
      } else if (mouseButton == CENTER) {
        x -= (pmouseX-mouseX)/scale; 
        y -= (pmouseY-mouseY)/scale;
      } else if (mouseButton == RIGHT) {
        zoom((pmouseX-mouseX)/40.);
      }
    }
    if (scale >= 1)
      scale(int(scale));
    else 
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

PImage getTile(PImage tile, int x, int y) {
  PImage img = createImage(16, 16, ARGB);
  img.copy(tile, x*16, y*16, 16, 16, 0, 0, 16, 16);
  return img;
}

