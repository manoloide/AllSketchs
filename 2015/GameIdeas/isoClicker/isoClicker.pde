int level = 0;
int clicks = 0;
int levelClicks = 20;

PFont font;

boolean clickAnimation;
float timeAnimation;

void setup() {
  size(600, 600, P3D);
  smooth(8);
  ortho(0, width, 0, height);
  colorMode(HSB, 256, 256, 256);

  font = createFont("Helvetica Neue Bold", 42, true);
  textFont(font);
  textAlign(CENTER, TOP);
}

void draw() {
  background(240);

  if (clickAnimation) {
    timeAnimation -= 1./60; 
    if (timeAnimation <= 0) {
      clickAnimation = false;
      timeAnimation = 0;
    }
  }
  pushMatrix();
  lights();
  translate(width/2, height/2);
  rotateX(PI/3);
  rotateZ(PI/4);
  noStroke();
  fill((frameCount/4)%256, 180, 255);
  float por = clicks*1./levelClicks;
  float size = 200;
  size *= 1-sin(abs(timeAnimation-0.05)*10)*0.1;
  translate(0, 0, -size/2+size*por/2);
  box(size, size, size*por);
  fill((frameCount/4+128)%256, 180, 255);
  if (por < 1) {
    translate(0, 0, size/2);
    box(size, size, size*(1-por));
  }
  popMatrix();

  fill(20);
  text("click: "+clicks, width/2, 30);
}

void mousePressed() {
  clickAnimation = true;
  timeAnimation = 0.1;
  clicks++;
  if (clicks > levelClicks) clicks = 0;
}

