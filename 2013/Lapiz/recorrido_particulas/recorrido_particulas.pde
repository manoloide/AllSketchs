import java.util.Calendar; //<>//

ArrayList<Particula> particulas;
ArrayList<Punto> puntos;
float estabilidad = 8;
float atraccion = 1.2;
PImage fondo;
void setup() {
  size(1600, 1600);
  //colorMode(HSB, 256);
  fondo = loadImage("fondo.png");
  thread("dibujar");
}

void draw() {
}

void dibujar() {
  image(fondo, 0, 0);
  puntos = new ArrayList<Punto>();
  particulas = new ArrayList();
  for (int i = 0; i < 2000; i++) {
    float ang = random(TWO_PI);
    float dis = 600-random(60)*random(5);
    float x = width/2+cos(ang)*dis;
    float y = height/2+sin(ang)*dis;
    puntos.add(new Punto(x, y));
    noStroke();
    fill(0, 200);
    //ellipse(x,y,3,3);
  }
  for (int i = 0; i < 400; i++) {
    float ang = random(TWO_PI);
    float dis = 600-random(120)*random(10);
    float x = width/2+cos(ang)*dis;
    float y = height/2+sin(ang)*dis;
    Particula aux = new Particula(x, y);
    particulas.add(aux);
    Punto pa = puntos.get(int(random(puntos.size())));
    aux.cambiarCentro(pa.x, pa.y);
  }
  for (int j = 0; j < 4000; j++) {
    frame.setTitle(j/4000.*100+"%");
    for (int i = 0; i < particulas.size(); i++) {
      Particula aux = particulas.get(i);
      aux.act();
      float ang = atan2(aux.y-aux.cy, aux.x-aux.cx);
      //stroke(map(ang, -PI, PI, 0, 256), dist(0, 200, 200, 120), dist(0, 200, 200, 120), 8);
      stroke(random(2)*random(1), random(3)*random(1), random(8)*random(3), 12);
      linea(aux.x, aux.y, aux.ax, aux.ay, 2);
      linea(aux.x, aux.y, aux.ax, aux.ay, 0.2);
      if (dist(aux.x, aux.y, aux.cx, aux.cy) < 1) {
        float tam = random(3);
        //fill(map(ang, -PI, PI, 0, 256), dist(0, 200, 200, 120), dist(0, 200, 200, 120), 255);
        fill(random(2)*random(1), random(3)*random(1), random(6)*random(5), 180);
        ellipse(aux.x, aux.y, tam, tam);
        Punto pa = puntos.get(int(random(puntos.size())));
        aux.cambiarCentro(pa.x, pa.y);
      }
    }
  }


  println("termino");
}

void keyPressed() {
  if (key=='s' || key=='S') saveFrame(timestamp()+"_##.png");
}
String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}
class Punto {
  float x, y; 
  Punto(float x, float y) {
    this.x = x; 
    this.y = y;
  }
}
void linea(float x1, float y1, float x2, float y2, float noise) {
  float dis = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  float ax = x1;
  float ay = y1;
  for (int i = 1; i < dis; i++) {
    float ra = random(TWO_PI);
    float rd = random(noise);
    float x = x1+cos(ang)*i+cos(ra)*rd;
    float y = y1+sin(ang)*i+sin(ra)*rd;
    line(ax, ay, x, y);
    ax = x;
    ay = y;
  }
}

class Particula {
  boolean eliminar;
  float x, y, cx, cy, ax, ay, dx, dy, vel, angui;
  Particula(float x, float y) {
    this.x = x;
    this.y = y;
    dx = random(0.2);
    dy = random(0.2);
    ax = 0; 
    ay = 0;
    vel = random(0.1, 0.4);
    eliminar = false;
  }
  void act() {
    ax = x;
    ay = y;
    float dist = dist(x, y, cx, cy);
    angui = atan2(cy-y, cx-x);
    x += (cos(dx*frameCount) * vel/2*dist/20 * estabilidad + cos(angui)*dist/10 * atraccion)/4;
    y += (cos(dy*frameCount) * vel/2*dist/20 * estabilidad + sin(angui)*dist/10 * atraccion)/4;
  }

  void dibujar() {
    noStroke();
    fill(255);
    ellipse(x, y, 8, 8);
  }
  void cambiarCentro(float cx, float cy) {
    this.cx = cx;
    this.cy = cy;
  }
}
