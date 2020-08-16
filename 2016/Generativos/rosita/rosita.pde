void setup() {
  size(960, 960);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(240);

  float bb = 10;
  float sep = 4;
  int cw = int(random(5, 40));
  int ch = int(random(2, 12));

  /*
  noStroke();
   float w = (width-bb*2.-sep*(cw-1))/cw;
   float h = (height-bb*2.-sep*(ch-1))/ch;
   for (int j = 0; j < ch; j++) {
   color c1 = rcol();
   color c2 = rcol();
   for (int i = 0; i < cw; i++) {
   fill(lerpColor(c1, c2, map(i, 0, cw-1, 0, 1)));
   rect(bb+i*(w+sep), bb+j*(h+sep), w, h);
   }
   }
   */

  for (int j = 0; j < 32; j++) {
    for (int i = 0; i < 32; i++) {
      Brush b = new Brush();
      float a = random(TWO_PI);
      float x = 15+30*i;
      float y = 15+30*j;
      x = random(width);
      y = random(height);
      float v = random(1, 20);
      for (int k = 0; k < 4; k++) {
        a += random(-0.4, 0.4);
        float ax = x;
        float ay = y;
        x += cos(a)*v;
        y += sin(a)*v;
        b.drawLine(g, ax, ay, x, y);
      }
    }
  }
}

int rcol() {
  pushStyle();
  colorMode(HSB, 360, 256, 256);
  float h = (random(30)+355)%360;
  float s = random(100, 256);
  float b = random(200, 256);
  color col = color(h, s, b);
  col = lerpColor(col, color(random(360), random(256), random(256)), random(0.1));
  popStyle();
  return col;
}

int rcol2() {
  return lerpColor(rcol(), rcol(), random(1));
}

class Brush {
  color colorFill;
  PImage brush, mask;

  Brush() {
    brush = createBrush();
    colorFill = rcol();
  }

  void drawLine(PGraphics gra, float x1, float y1, float x2, float y2) {
    drawLine(gra, x1, y1, 1, x2, y2, 1);
  }

  void drawLine(PGraphics gra, float x1, float y1, float p1, float x2, float y2, float p2) {
    gra.beginDraw();
    gra.imageMode(CENTER);
    float ang = atan2(y2-y1, x2-x1);
    float dis = dist(x1, y1, x2, y2);
    gra.tint(colorFill, 120);
    for (float i = 0; i <= dis; i+=0.5) {
      float x = x1+cos(ang)*i;
      float y = y1+sin(ang)*i;
      float det = map(i, 0, dis, p1, p2);
      gra.image(brush, x, y, brush.width*det, brush.height*det);
    }
    gra.endDraw();
  }

  PImage createBrush() {
    int ss = int(random(38, 80));
    //int ss = int(random(8, 50));
    PGraphics aux = createGraphics(ss, ss);
    aux.beginDraw();
    aux.noStroke();
    aux.fill(255, 1);
    aux.ellipse(ss/2, ss/2, ss*0.9, ss*0.9);
    int cc = max(20, ss*3);
    for (int i = 0; i < cc; i++) {
      aux.fill(random(220, 255));
      float ang = random(TWO_PI);
      float dis = random(25);
      float s = map(dis, 0, ss*0.5, ss*0.08, 0)*random(-1, 1);
      float x = ss/2+cos(ang)*dis;
      float y = ss/2+sin(ang)*dis;
      aux.ellipse(x, y, s, s);
    }
    aux.filter(BLUR, 0.5);
    aux.endDraw();
    return aux.get();
  }
}