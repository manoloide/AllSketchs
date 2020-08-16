void setup() {
  size(960, 960, P3D);
  smooth(8);
  generate();
}

void draw() {
  if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String name = nf(day(), 2)+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2);
  saveFrame(name+".png");
}

void generate() {
  PImage tex = getTex();

  translate(width/2, height/2, 0);
  rotateX(random(-0.5, 0.5));
  rotateY(random(-0.5, 0.5));
  rotateZ(random(TWO_PI));
  translate(-tex.width/2, -tex.height/2);
  beginShape();
  texture(tex);
  vertex(0, 0, 0, 0);
  vertex(tex.width, 0, tex.width, 0);
  vertex(tex.width, tex.height, tex.width, tex.height);
  vertex(0, tex.height, 0, tex.height);
  endShape(CLOSE);


  noStroke();
  for (int i = 0; i < 100; i++) {
    float s = random(300)*random(1);
    float x = random(s, tex.width-2);
    float y = random(s, tex.height-2); 
    float h = random(0.2, 1)*s;
    for (int j = 0; j < 4; j++) {
      float da = (j*2+1)*PI*0.25;
      beginShape();
      texture(tex);
      vertex(x+cos(da)*s, y+sin(da)*s, 0, x+cos(da)*s, y+sin(da)*s);
      vertex(x+cos(da+PI*0.5)*s, y+sin(da+PI*0.5)*s, 0, x+cos(da+PI*0.5)*s, y+sin(da+PI*0.5)*s);
      vertex(x, y, h, x, y);
      endShape();
    }
  }
}

PImage getTex() {
  PGraphics gra = createGraphics(2048, 2048);

  gra.beginDraw();
  gra.background(255, 0, 40);
  gra.smooth(8);
  float sep = random(2, 40);
  float a1 = random(1);
  float a2 = 1-a1;
  float d1 = a1*sep*0.5;
  float d2 = a2*sep*0.5;
  gra.noStroke();
  gra.fill(10, 20, 255);
  for (float i = random(-sep); i <= gra.height+sep; i+=sep) {
    gra.beginShape();
    gra.vertex(0, i-d1);
    gra.vertex(gra.width, i-d2);
    gra.vertex(gra.width, i+d2);
    gra.vertex(0, i+d1);
    gra.endShape(CLOSE);
  }
  gra.endDraw();
  return gra.copy();
}