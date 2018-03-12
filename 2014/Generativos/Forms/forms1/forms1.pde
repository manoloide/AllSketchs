 //<>// //<>//
color[] paleta;

void setup() {
  size(600, 800);
  smooth(8);
  paleta = new color[5];
  paleta[0] = color(#FD0F65);
  paleta[1] = color(#FB6159);
  paleta[2] = color(#FFA85E);
  paleta[3] = color(#FFDF61);
  paleta[4] = color(#E5CA9D);
  background(255);
  generar();
}

void generar() {
  noFill();
  //background(paleta[int(random(5))]);
  for (int i = 0; i < 20; i++) {
    float tam = random(60, 200);
    //fill(paleta[int(random(5))], 255-(tam*0.6));
    Form f = new Form(random(width), random(height), 4, tam);
    f.dibujar();
  }
}

void draw() {
}

void keyPressed() {
  if (key == 's') {
    saveFrame("####");
  }
  else {
    generar();
  }
}

class Point {
  float x, y;
  Point(float x, float y) {
    this.x = x; 
    this.y = y;
  }
}

class Line {
  Point p1, p2;
  Line(Point p1, Point p2) {
    this.p1 = p1;
    this.p2 = p2;
  }
}

class Form {
  ArrayList<Point> points;
  int cant;
  float x, y, w, h, dig;
  Form(float ix, float iy, int cant, float tam) {
    this.x = ix; 
    this.y = iy; 
    this.cant = cant;

    float dang = random(TWO_PI);
    points = new ArrayList<Point>();
    for (int i = 0; i < cant; i++) {
      float dis = random(tam*0.8, tam*1.2);
      float cang = TWO_PI/cant;
      float ang = random(cang*i, cang*(i+1)) + dang;
      float xx = cos(ang)*dis; 
      float yy = sin(ang)*dis; 
      points.add(new Point(xx, yy));
    }
    float xmin, xmax, ymin, ymax;
    xmin = xmax = x;
    ymin = ymax = y;
    for (int i = 0; i < cant; i++) {
      Point aux = points.get(i);
      if (x+aux.x < xmin) xmin = x+aux.x;
      if (x+aux.x > xmax) xmax = x+aux.x;
      if (y+aux.y < ymin) ymin = y+aux.y;
      if (y+aux.y > ymax) ymax = y+aux.y;
    }
    w = xmax-xmin;
    h = ymax-ymin;
    x = xmin + w/2;
    y = ymin + h/2;
    dig = dist(xmin, ymin, xmax, ymax);
    for (int i = 0; i < cant; i++) {
      Point aux = points.get(i);
      aux.x += ix-x;
      aux.y += iy-y;
    }
  }
  void dibujar() {
    stroke(0, 80);
    //noStroke();
    beginShape();
    for (int i = 0; i < cant; i++) {
      Point aux = points.get(i);
      vertex(x+aux.x, y+aux.y);
    }
    endShape(CLOSE);
    noFill();
    rect(x-w/2, y-h/2, w, h);
    int ct = 10;
    line(x-ct, y-ct, x+ct, y+ct);
    line(x+ct, y-ct, x-ct, y+ct);
    ellipse(x, y, dig, dig);
    float tam = 4;
    int cl = int(dig/tam);
    float ang = random(TWO_PI);
    float des = ang+PI/2;
    float rad = dig/2;
    ArrayList<Line> lineas = new ArrayList<Line>();
    for (int i = -cl/2; i <= cl/2; i++) {
      float dx = cos(des)*tam*i;
      float dy = sin(des)*tam*i;
      //ellipse(x+dx, y+dy, 4, 4);
      float x1 = x+dx+cos(ang)*rad;
      float y1 = y+dy+sin(ang)*rad;
      float x2 = x+dx+cos(ang)*(-rad);
      float y2 = y+dy+sin(ang)*(-rad);
      ArrayList<Point> linea = new ArrayList<Point>();
      for (int j = 0; j < cant; j++) {
        Point p1 = points.get(j);
        Point p2 = points.get((j+1)%cant);
        Point in = intersection(x+p1.x, y+p1.y, x+p2.x, y+p2.y, x1, y1, x2, y2);
        if (in != null) {
          linea.add(in);
          ellipse(in.x, in.y, 4, 4);
        }
      }
      if (linea.size() == 2) {
        Point p1 = linea.get(0);
        Point p2 = linea.get(1);
        lineas.add(new Line(p1, p2));
        line(p1.x, p1.y, p2.x, p2.y);
      }
      //line(x1, y1, x2, y2);
    }
    for (int i = 1; i < lineas.size(); i++) {
      Line l1 = lineas.get(i-1);
      Line l2 = lineas.get(i);
      if (i%2 == 0) fill(0, 20);
      else fill(255, 20);
      //quad(l1.p1.x, l1.p1.y, l1.p2.x, l1.p2.y, l2.p2.x, l2.p2.y, l2.p1.x, l2.p1.y);
    }
  }
}

Point intersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float d = (x1-x2)*(y3-y4) - (y1-y2)*(x3-x4);
  if (d == 0) return null;

  float xi = ((x3-x4)*(x1*y2-y1*x2)-(x1-x2)*(x3*y4-y3*x4))/d;
  float yi = ((y3-y4)*(x1*y2-y1*x2)-(y1-y2)*(x3*y4-y3*x4))/d;

  Point p = new Point(xi, yi);
  if (xi < Math.min(x1, x2) || xi > Math.max(x1, x2)) return null;
  if (xi < Math.min(x3, x4) || xi > Math.max(x3, x4)) return null;
  return p;
}
