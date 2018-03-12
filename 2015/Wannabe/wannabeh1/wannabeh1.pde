/* @pjs font="Exo-Medium.ttf"; */

boolean randPosition;
int cantParticle;
int sep;
float minSize, maxSize, velocity1, velocity2, mouseDist;

int paleta[] = {
  #87ffe1, 
  #f5871e, 
  #eb4b9b, 
  #faf08c
};

/*
int paleta[] = {
 #FFFFFF
 };
 */


ArrayList<Particle> particles;
boolean mouseMoving;

PGraphics mask;
PFont font;

void setup() {

  randPosition = false;
  cantParticle = 2000;
  sep = 4;
  minSize = 3; 
  maxSize = 4;
  velocity1 = 0.2;
  velocity2 = 0.1;
  mouseDist = 60;

  size(700, 120);
  frameRate(30);
  font = createFont("Exo Medium", 100, true);
  mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.textFont(font);
  mask.textAlign(CENTER, TOP);
  mask.text("Wannabe", width/2, -10);
  mask.endDraw();

  particles = new ArrayList<Particle>();

  if (randPosition) {
    while (particles.size () < cantParticle) {
      float x = random(width);
      float y = random(height);
      if (brightness(mask.get(int(x), int(y))) > 200) {
        particles.add(new Particle(x, y));
      }
    }
  } else {
    for (int j = 0; j < height; j+=sep) {
      for (int i = 0; i < width; i+=sep) {
        float x = i;
        float y = j;
        if (brightness(mask.get(int(x), int(y))) > 200) {
          particles.add(new Particle(x, y));
        }
      }
    }
  }
}

void draw() {
  background(0);
  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.update();
  }
  mouseMoving = false;
}

void mouseMoved() {
  mouseMoving = true;
}

class Particle {
  color col; 
  float cx, cy, x, y;
  float s, ss;
  float ang;
  Particle(float x, float y) {
    this.x = cx = x;
    this.y = cy = y;
    s = random(minSize, maxSize);
    col = color(255);//color(random(256), random(256), random(256));
    col = rcol();
    ang = random(TWO_PI);
    float disCen = dist(cx, cy, x, y);
    ss = s-s*(disCen/mouseDist);
  }
  void update() {
    float disCen = dist(cx, cy, x, y);
    float disMou = dist(mouseX, mouseY, x, y);
    //ang = atan2(mouseY-y, mouseX-x);
    ang += random(-0.1, 0.1);
    if (mouseMoving && disMou < mouseDist+random(10)) {
      x -= cos(ang) * disMou * velocity1;
      y -= sin(ang) * disMou * velocity1;
      ss = s-(s*(disCen/mouseDist)*0.5);
    } else if (disCen > 0) {
      ang = atan2(cy-y, cx-x);
      x += cos(ang) * disCen * velocity2;
      y += sin(ang) * disCen * velocity2;
      ss = s-s*(disCen/mouseDist);
    }
    show();
  }

  void show() {
    noStroke();
    fill(col);
    ellipse(x, y, ss, ss);
  }
}

int rcol() {
  return paleta[int(random(paleta.length))];
}