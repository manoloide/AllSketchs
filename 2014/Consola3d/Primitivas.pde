class Objeto {
  boolean eliminar; 
  float x, y, z;
  void act() {
  }
}

class Plane extends Objeto {
  PImage img;
  float w, h;
  Plane(float x, float y, float z, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.z = z;
    this.w = w;
    this.h = h;
    img = createImage(int(w), int(h), RGB);
    color col = paleta[int(random(5))];
    for (int i = 0; i < img.pixels.length; i++) {
      img.pixels[i] = col;
    }
  }
  void act() {
    dibujar();
  }
  void dibujar() {
    noStroke();
    float w = this.w/2;
    float h = this.h/2;
    beginShape(QUADS);
    texture(img);  
    vertex(x-w, y-h, z, 0, 0);
    vertex(x+w, y-h, z, 1, 0);
    vertex(x+w, y+h, z, 1, 1);
    vertex(x-w, y+h, z, 0, 1);
    endShape();
  }
}
class Point {
  float x, y, z;
  Point() {
    x = y = z = 0;
  }
  Point(float x, float y, float z) {
    this.x = x; 
    this.y = y; 
    this.z = z;
  }
}
class Line {
  Point p1, p2;
  Line(float x1, float y1, float z1, float x2, float y2, float z2) {
    p1 = new Point(x1, y1, z1);
    p2 = new Point(x2, y2, z2);
  }
  void dibujar() {
    line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
  }
}
class Tree extends Objeto {
  ArrayList<Line> ramas;
  Tree(float x, float y, float z) {
    this.x = x; 
    this.y = y; 
    this.z = z;
    ramas = new ArrayList<Line>();
    agregarRama(new Line(x, y, z, x+random(-10, 10), y-400, z+random(-10, 10)), 3);
  }
  void act() {
    dibujar();
  }
  void dibujar() {
    stroke(0);
    for (int i = 0; i < ramas.size(); i++) {
      ramas.get(i).dibujar();
    }
  }
  void agregarRama(Line l, int n) {
    n--;
    ramas.add(l);
    if (n > 0) {
      float dist = dist(l.p1.x, l.p1.y, l.p1.z, l.p2.x, l.p2.y, l.p2.z); 
      int cant = int(random(1)+random(1)+random(1));
      for (int i = 0; i < cant; i++) {
        float ang1 = random(PI, TWO_PI);
        float ang2 = random(PI);
        float mx = sin(ang1)*cos(ang2)*dist*0.6;
        float my = sin(ang1)*sin(ang2)*dist*0.6;
        float mz = cos(ang1)*dist*0.6; 
        Line aux = new Line(l.p2.x, l.p2.y, l.p2.z, l.p2.x+mx, l.p2.y+my, l.p2.z+mz);
        agregarRama(aux, n);
      }
    }
  }
}

class Box extends Objeto {
  color c1, c2;
  float d;
  PImage arriba, abajo, costado1, costado2;
  Box(float x, float y, float z, float d) {
    this.x = x; 
    this.y = y;
    this.z = z;
    this.d = d;

    c1 = paleta[int(random(5))];
    c2 = paleta[int(random(5))];
    while (c1 == c2) {
      c2 = paleta[int(random(5))];
    }
    generarCaras();
  }
  void act() {
    dibujar();
  }
  void dibujar() {
    noStroke();
    float d = this.d/2;
    beginShape(QUADS);
    texture(costado1);
    vertex(x-d, y-d, z+d, 0, 0);
    vertex(x+d, y-d, z+d, 1, 0);
    vertex(x+d, y+d, z+d, 1, 1);
    vertex(x-d, y+d, z+d, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(costado1);
    vertex(x+d, y-d, z-d, 0, 0);
    vertex(x-d, y-d, z-d, 1, 0);
    vertex(x-d, y+d, z-d, 1, 1);
    vertex(x+d, y+d, z-d, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(abajo);
    vertex(x-d, y+d, z+d, 0, 0);
    vertex(x+d, y+d, z+d, 1, 0);
    vertex(x+d, y+d, z-d, 1, 1);
    vertex(x-d, y+d, z-d, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(arriba);
    vertex(x-d, y-d, z-d, 0, 0);
    vertex(x+d, y-d, z-d, 1, 0);
    vertex(x+d, y-d, z+d, 1, 1);
    vertex(x-d, y-d, z+d, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(costado2);
    vertex(x+d, y-d, z+d, 0, 0);
    vertex(x+d, y-d, z-d, 1, 0);
    vertex(x+d, y+d, z-d, 1, 1);
    vertex(x+d, y+d, z+d, 0, 1);
    endShape();
    beginShape(QUADS);
    texture(costado2);
    vertex(x-d, y-d, z-d, 0, 0);
    vertex(x-d, y-d, z+d, 1, 0);
    vertex(x-d, y+d, z+d, 1, 1);
    vertex(x-d, y+d, z-d, 0, 1);
    endShape();
  }
  void generarCaras() {
    int d = int(this.d);
    arriba = createImage(d, d, RGB);
    abajo = createImage(d, d, RGB);
    costado1 = createImage(d, d, RGB);
    costado2 = createImage(d, d, RGB);
    for (int i = 0; i < arriba.pixels.length; i++) {
      arriba.pixels[i] = c2;
      abajo.pixels[i] = c1;
    }
    for (int j = 0; j < d; j++) {
      color col1 = lerpColor(c1, c2, map(j, 0, d, 1, 0));
      color col2 = lerpColor(c1, c2, map(j, 0, d, 1, 0));
      for (int i = 0; i < d; i++) {
        costado1.set(i, j, col1);
        costado2.set(i, j, col2);
      }
    }
  }
}

class Ico extends Objeto{
  color c1, c2;
  float d;
  PImage costado1, costado2;
  Ico(float x, float y, float z, float d) {
    this.x = x; 
    this.y = y;
    this.z = z;
    this.d = d;

    c1 = paleta[int(random(5))];
    c2 = paleta[int(random(5))];
    while (c1 == c2) {
      c2 = paleta[int(random(5))];
    }
    generarCaras();
  }
  void act() {
    dibujar();
  }
  void dibujar() {
    noStroke();
    float h = d*0.8;
    float d = this.d/2;
    beginShape(TRIANGLE_STRIP);
    texture(costado1);
    vertex(x-d, y, z-d, 0, 0);
    vertex(x+d, y, z-d, 1, 0);
    vertex(x, y+h, z, 0.5, 1);
    endShape();
    beginShape(TRIANGLE_STRIP);
    texture(costado1);
    vertex(x+d, y, z-d, 0, 0);
    vertex(x+d, y, z+d, 1, 0);
    vertex(x, y+h, z, 0.5, 1);
    endShape();
    beginShape(TRIANGLE_STRIP);
    texture(costado1);
    vertex(x+d, y, z+d, 0, 0);
    vertex(x-d, y, z+d, 1, 0);
    vertex(x, y+h, z, 0.5, 1);
    endShape();
    beginShape(TRIANGLE_STRIP);
    texture(costado1);
    vertex(x-d, y, z+d, 0, 0);
    vertex(x-d, y, z-d, 1, 0);
    vertex(x, y+h, z, 0.5, 1);
    endShape();

    beginShape(TRIANGLE_STRIP);
    texture(costado2);
    vertex(x-d, y, z-d, 0, 0);
    vertex(x+d, y, z-d, 1, 0);
    vertex(x, y-h, z, 0.5, 1);
    endShape();
    beginShape(TRIANGLE_STRIP);
    texture(costado2);
    vertex(x+d, y, z-d, 0, 0);
    vertex(x+d, y, z+d, 1, 0);
    vertex(x, y-h, z, 0.5, 1);
    endShape();
    beginShape(TRIANGLE_STRIP);
    texture(costado2);
    vertex(x+d, y, z+d, 0, 0);
    vertex(x-d, y, z+d, 1, 0);
    vertex(x, y-h, z, 0.5, 1);
    endShape();
    beginShape(TRIANGLE_STRIP);
    texture(costado2);
    vertex(x-d, y, z+d, 0, 0);
    vertex(x-d, y, z-d, 1, 0);
    vertex(x, y-h, z, 0.5, 1);
    endShape();
  }
  void generarCaras() {
    int d = int(this.d);
    costado1 = createImage(d, d, RGB);
    costado2 = createImage(d, d, RGB);
    for (int j = 0; j < d; j++) {
      color col1 = lerpColor(c1, c2, map(j, 0, d, 1, 0));
      color col2 = lerpColor(c1, c2, map(j, 0, d, 1, 0));
      for (int i = 0; i < d; i++) {
        costado1.set(i, j, col1);
        costado2.set(i, j, col2);
      }
    }
  }
}
