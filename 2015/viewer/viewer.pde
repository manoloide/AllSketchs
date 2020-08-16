int colors[][] = { 
  {
    #FF4E50, 
    #FC913A, 
    #F9D423, 
    #EDE574, 
    #E1F5C4
  }
  , 
  {
    #F8B195, 
    #F67280, 
    #C06C84, 
    #6C5B7B, 
    #355C7D
  }
  , 
  {
    #1B676B, 
    #519548, 
    #88C425, 
    #BEF202, 
    #EAFDE6
  }
  , 
  {
    #607848, 
    #789048, 
    #C0D860, 
    #F0F0D8, 
    #604848
  }
  , 
  {
    #1C2130, 
    #028F76, 
    #B3E099, 
    #FFEAAD, 
    #D14334
  }
  , 
  {
    #230F2B, 
    #F21D41, 
    #EBEBBC, 
    #BCE3C5, 
    #82B3AE
  }
};

int paleta;

Camera camera;
float kappa;
PGraphics gra;

void setup() {
  size(800, 800);
  camera = new Camera();
  frame.setResizable(true);
  generate();
  kappa = 4*(sqrt(2)-1)/3;
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
  int w = 1753;
  int h = 2480;
  gra = createGraphics(w, h);
  paleta = int(random(colors.length));

  gra.beginDraw();
  gra.background(rcol());
  int sep = int(random(10, 60));
  gra.stroke(rcol());
  gra.strokeWeight(sep*random(0.1, 0.4));
  for (int i = int (random (-sep)); i < w+h; i+=sep) {
    gra.line(-2, i, i, -2);
  }
  for (int i = 0; i < 1000; i++) {
    float x = random(w);
    float y = random(h);
    float s = random(5, 20);
    int c = rcol();
    gra.noStroke();
    gra.fill(c, 50);
    gra.ellipse(x, y, s, s);
    s *= 0.8; 
    gra.fill(c);
    gra.ellipse(x, y, s, s);
  }

  {
    gra.fill(rcol());
    float x1 = random(w);
    float y1 = random(h);
    float x2 = random(w);
    float y2 = random(h);
    /*
    gra.ellipse(x1, y1, 100, 100);
     gra.ellipse(x2, y2, 100, 100);
     */
    float r1 = random(100, 500);
    float k1 = r1*kappa;
    float r2 = random(100, 500);
    float k2 = r2*kappa;
    float a = atan2(y2-y1, x2-x1);
    gra.stroke(0);
    gra.line(x1, y1, x2, y2);
    gra.fill(255);
    gra.ellipse(x1, y1, r1*2, r1*2);
    gra.fill(0);
    gra.beginShape();
    for (int i = 0; i < 4; i++) {
      float ang = a+PI/2*i;
      float xx1 = x1+cos(ang)*r1;
      float yy1 = y1+sin(ang)*r1;
      float xx2 = x1+cos(ang+PI/2)*r1;
      float yy2 = y1+sin(ang+PI/2)*r1;
      float cx1 = xx1+cos(ang+PI/2)*k1;
      float cy1 = yy1+sin(ang+PI/2)*k1;
      float cx2 = xx2+cos(ang)*k1;
      float cy2 = yy2+sin(ang)*k1;
      //gra.vertex(xx1, yy1);
      //gra.bezierVertex(cx1, cy1, cx2, cy2, xx2, yy2);
      gra.ellipse(xx1, yy1, 40, 40);
      gra.ellipse(xx2, yy2, 40, 40);
      gra.ellipse(cx1, cy1, 20, 20);
      gra.ellipse(cx2, cy2, 20, 20);
    }
    gra.endShape(CLOSE);

    gra.stroke(0);
    gra.fill(255);
    gra.ellipse(x2, y2, r2*2, r2*2);
    gra.fill(0);
    for (int i = 0; i < 4; i++) {
      float ang = a+PI/2*i;
      float x = x2+cos(ang)*r2;
      float y = y2+sin(ang)*r2;
      gra.ellipse(x, y, 40, 40);
      gra.line(x, y, x+cos(ang+PI/2)*k2, y+sin(ang+PI/2)*k2);
    }
  }
/*
  for (int j = 0; j < 10; j++) {
    int cc = int(random(3, 100));
    float x = w/2*random(0.1, 1.9); 
    float y = h/2*random(0.1, 1.9);
    float d = w*random(0.3, 0.86)*random(0.02, 1);
    int c = int(random(3, 12));
    float a = random(TWO_PI);
    int c1 = rcol();
    int c2 = rcol();
    gra.strokeWeight(random(d/cc/5));
    while (c1 == c2) c2 = rcol();
    for (int i = 1; i <= cc; i++) {
      float dd = d-(d/cc)*i;
      gra.fill((i%2==0)? c1 : c2);
      poly(x, y, dd, c, a);
    }
  }*/


  for (int i = 0; i < 300; i++) {
    float x = random(w);
    float y = random(h);
    float d = random(20, 300);
    float a = random(TWO_PI);
    float s = random(0.2, 0.8);
    gra.strokeWeight(d*random(0.01, 0.2));
    gra.fill(lerpColor(color(rcol()), color(255), random(0.1, 0.9)));
    cross(x, y, d, a, s);
  }


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
  return colors[paleta][int(random(colors[0].length))];
}

