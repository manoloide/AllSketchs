ArrayList<Punto> puntos;

void setup() {
  size(800, 600, P3D); 
  puntos = new ArrayList<Punto>();
  for (int i = 0; i < 4000; i++) {
    puntos.add(new Punto(random(-width, width), random(-height, height), random(-1000, 1000)));
  }
  noSmooth();
  background(0);
  stroke(255);
  fill(255);
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
}

void draw() {
  if (frameCount%800 < 0) {
    noStroke();
    for (int i = 0; i < 100; i++) {
      switch(int(random(3))) {
      case 0:
        fill(255, 0, 0);
        break;
      case 1:
        fill(0, 255, 0);
        break;
      case 2:
        fill( 0, 0, 255);
        break;
      }
      rect(int(random(width/4))*4, int(random(height/4))*4, 4, 4);
    }
  }
  else {
    translate(width/2,height/2, -height);
    background(0);
    rotateX(TWO_PI * ((frameCount%100)*1./100));
    rotateY(TWO_PI * ((frameCount%200)*1./200));
    rotateZ(TWO_PI * ((frameCount%354)*1./354));
    for (int i = 0; i < puntos.size(); i++) {
      Punto a = puntos.get(i); 
      a.act();    
      for (int j = i+1;  j < puntos.size(); j++) {
        Punto a2 = puntos.get(j);
        if (a.dis(a2) < 90) {
          line(a.x, a.y, a.z, a2.x, a2.y, a2.z);
        }
      }
    }
  }
  //saveFrame("locura####.png");
  if (frameCount >= 1000) {
    exit();
  }
}

class Punto {
  color col; 
  float x, y, z;
  Punto(float x, float y, float z) {
    this.x = x; 
    this.y = y; 
    this.z = z;
    switch(int(random(3))) {
    case 0:
      col = color(255, 0, 0);
      break;
    case 1:
      col = color(0, 255, 0);
      break;
    case 2:
      col = color( 0, 0, 255);
      break;
    }
  }
  void act() {
    dibujar();
  }

  void dibujar() {
    stroke(col);
    point(x, y, z);
  }
  float dis(Punto o) {
    return dist(x, y, z, o.x, o.y, o.z);
  }
}

