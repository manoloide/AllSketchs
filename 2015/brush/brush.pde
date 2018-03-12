import codeanticode.tablet.*;

PImage img;
Tablet tablet;
float ap;

int paleta[] = {
  #03E3FC, 
  #AEFC03, 
  #D702FC, 
  #3B42A8, 
  #F9043D
};

Brush brush;
PGraphics col;
PGraphics canvas;

void setup() {
  size(720, 480);
  tablet = new Tablet(this); 

  brush = new Brush();

  canvas = createGraphics(width, height);
  canvas.beginDraw();
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      canvas.set(i, j, color(random(246, 250)));
    }
  }
  canvas.endDraw();

  //img = loadImage("https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xtf1/v/t1.0-9/10306470_10206238152971150_4633734076980878238_n.jpg?oh=2344f2ffc408353ac6749e0705d331ec&oe=56EED462&__gda__=1456977478_ea34525ec766cfa147ccad6fd2fdbb98");
  //thread("processImage");
}

void draw() {
  background(120);
  image(canvas, 0, 0);
  ap = tablet.getPressure();
}

void keyPressed() {
  if (key == 's') saveImage();
  else if (key == 'c') brush = new Brush();
  else thread("generate");
}

void processImage() {
  int cc = 100;
  Brush[] brushs = new Brush[cc];
  PVector[] points = new PVector[cc];
  for (int i = 0; i < brushs.length; i++) {
    brushs[i] = new Brush();
    float x = img.width*random(0.2, 0.8);
    float y = img.height*random(0.2, 0.8);
    points[i] = new PVector(x, y, random(TWO_PI));
    brushs[i].colorFill = img.get(int(x), int(y));
  }

  for (int c = 0; c < 100; c++) {
    for (int i = 0; i < brushs.length; i++) {
      points[i].z += random(-0.8, 0.8);
      float d = random(2, 5);
      float ax = points[i].x;
      float ay = points[i].y;
      float x = points[i].x += cos(points[i].z)*d;
      float y = points[i].y += sin(points[i].z)*d;
      brushs[i].colorFill = lerpColor(brushs[i].colorFill, img.get(int(x), int(y)), 0.5);
      brushs[i].drawLine(canvas, ax, ay, 1, x, y, 1);
    }
  }
}
void generate() {
  /*
  canvas = createGraphics(width, height);
   canvas.beginDraw();
   canvas.background(250);
   canvas.endDraw();
   */
  /*
  for (int i = 0; i < 100; i++) {
   Brush brush = new Brush();
   PVector pos = new PVector(width*random(0.3, 0.7), height*random(0.3, 0.7), random(TWO_PI));
   int cc = 200;
   float amp = random(0.1, 1);
   float loc = random(0.03, 0.4);
   float vel = random(1, 4);
   for (int j = 0; j < cc; j++) {
   float a1 = 1-(abs((j-1)-cc/2.))/(cc/2.);
   float a2 = 1-(abs(j-cc/2.))/(cc/2.);
   float x1 = pos.x; 
   float y1 = pos.y;
   pos.z += random(-loc, loc);
   pos.x += cos(pos.z)*vel;
   pos.y += sin(pos.z)*vel;
   brush.drawLine(canvas, x1, y1, a1, pos.x, pos.y, a2);
   }
   }
   
   */

  canvas = createGraphics(width, height);
  canvas.beginDraw();
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      canvas.set(i, j, color(random(246, 250)));
    }
  }
  canvas.endDraw();

  int tt = int(random(40, 180));

  int cw = width/tt-1;
  int ch = height/tt-1;

  int dx = (width-cw*tt)/2+tt/2;
  int dy = (height-ch*tt)/2+tt/2;

  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float x = dx + i*tt;
      float y = dy + j*tt;
      float st = tt*0.3;
      float gro = random(0.05, 0.5);
      Brush b = new Brush();
      if (random(1) < 0.5) {
        b.drawLine(canvas, x-st, y-st, gro, x+st, y-st, gro);
        b.drawLine(canvas, x+st, y-st, gro, x+st, y+st, gro);
        b.drawLine(canvas, x+st, y+st, gro, x-st, y+st, gro);
        b.drawLine(canvas, x-st, y+st, gro, x-st, y-st, gro);
      } else {
        int reso = 50;
        float da = TWO_PI/reso;
        float x1 = x+cos(0)*st;
        float y1 = y+sin(0)*st;
        for (int k = 1; k <= reso; k++) {  
          float x2 = x+cos(k*da)*st;
          float y2 = y+sin(k*da)*st;
          b.drawLine(canvas, x1, y1, gro, x2, y2, gro);
          x1 = x2;
          y1 = y2;
        }
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void mousePressed() {
  brush.drawLine(canvas, mouseX, mouseY, tablet.getPressure(), mouseX, mouseY, tablet.getPressure());
}

void mouseDragged() {
  //brush.drawLine(canvas, pmouseX, pmouseY, ap, mouseX, mouseY, tablet.getPressure());
  brush.drawLine(canvas, pmouseX, pmouseY, 1, mouseX, mouseY, 1);
} 


class Brush {
  color colorFill;
  PImage brush, mask;

  Brush() {
    brush = createBrush();
    colorFill = color(random(256), random(256), random(256));
    colorFill = mcol();
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

int rcol() {
  return paleta[int(random(paleta.length))];
} 

int mcol() {
  return lerpColor(lerpColor(rcol(), rcol(), random(1)), rcol(), random(0.5, 1));
}

