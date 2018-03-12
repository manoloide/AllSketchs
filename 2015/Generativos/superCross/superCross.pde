int seed = 0;
int colors[] = {
};


Camera camera;
PGraphics gra;

void setup() {
  size(displayWidth, displayHeight);
  camera = new Camera();
  frame.setResizable(true);
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
  if (keyCode == LEFT) {
    seed--;
    generate();
  }
  if (keyCode == RIGHT) {
    seed++;
    generate();
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  camera.zoom(e);
}

void generate() {
  int w = 2560;
  int h = 1440;
  /*
  PImage img = loadImage("https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-frc3/v/t1.0-9/10411984_10204289879348359_1144123301449970042_n.jpg?oh=f2933d12f4ddb0d2add569b36b5c2de8&oe=56CFC00F&__gda__=1452884489_6841b02fe803bbf1668d34ee6df85199");
  w = img.width*2;
  h = img.height*2;
  */
  gra = createGraphics(w, h);
  gra.smooth(8);
  randomSeed(seed);
  gra.beginDraw();
  gra.background(255);
  gra.scale(1.2);
  for (int j = 0; j < 2000; j++) {
    float x = random(w);
    float y = random(h);
    float md = random(10, random(100, 240));
    gra.stroke(0, 80);
    for (int i = 0; i < 300; i++) {
      float a = random(TWO_PI);
      float d = random(md);
      float t = map(sin(d/md*PI/2), 0, 1, md/4, 0);
      float xx = x+cos(a)*d;
      float yy = y+sin(a)*d;
      //gra.fill(img.get(int(xx/2), int(yy/2)));
      //
      //gra.noStroke();
      cross(xx, yy, t, a, random(0.01, 0.3));
    }
  }
  /*
  for (int i = 0; i < 1000; i++) {
   float x = random(w);
   float y = random(h);
   float a = random(TWO_PI);
   float d = random(5, 180)*random(1);
   gra.fill(128+y/h*128);
   gra.stroke(0, 80);
   cross(x, y, d, a, 0.2);
   }
   {
   float xx = width*random(0.1, 0.9);
   float yy = height*random(0.1, 0.9);
   for (int i = 0; i < 1000; i++) {
   float x = random(w);
   float y = random(h);
   float a = random(TWO_PI);
   float d = random(5, 180)*random(1);
   gra.fill(128-y/h*128);
   gra.ellipse(x, y, d*1.2, d*1.2);
   gra.fill(128+y/h*128);
   gra.stroke(0, 80);
   cross(x, y, d, a, 0.2);
   }
   }
   */
  gra.endDraw();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  gra.save(timestamp+".png");
}

void cross(float x, float y, float d, float a, float s) {
  float r = d*0.5;
  float sep = r*s;
  float r2 = dist(sep, 0, 0, sep);
  float da = TWO_PI/4;
  gra.beginShape();
  for (int i = 0; i < 4; i++) {
    float ang = a+da*i;
    gra.vertex(x+cos(ang-PI/4)*r2, y+sin(ang-PI/4)*r2);
    float sx = cos(ang-PI/2)*sep; 
    float sy = sin(ang-PI/2)*sep;
    float xx = x+cos(ang)*r;
    float yy = y+sin(ang)*r;
    gra.vertex(xx+sx, yy+sy);
    gra.vertex(xx-sx, yy-sy);
  }
  gra.endShape(CLOSE);
}

void poly(float x, float y, float d, int c, float a) {
  float r = d*0.5;
  float da = TWO_PI/c;
  gra.beginShape();
  for (int i = 0; i < c; i++) {
    gra.vertex(x+cos(da*i+a)*r, y+sin(da*i+a)*r);
  }
  gra.endShape(CLOSE);
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


int rcol() {
  return colors[int(random(colors.length))];
}

