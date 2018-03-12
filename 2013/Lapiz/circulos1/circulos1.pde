import java.util.Calendar; //<>//

ArrayList<Punto> puntos;
PImage fondo;
void setup() {
  size(800, 800);
  colorMode(HSB, 256);
  fondo = loadImage("fondo.png");
  thread("dibujar");
}

void draw() {
}

void dibujar() {
  image(fondo,0,0);
  puntos = new ArrayList<Punto>();
  puntos.add(new Punto(width/2, height/2));
  for (int j = 0; j < width/2+120;j += 20) {
    int cant = j/3;
    float desang = TWO_PI/cant;
    float des = random(desang);
    for (int i = 0; i < cant; i++) {
      float ang = des+i*desang;
      puntos.add(new Punto(width/2+cos(ang)*j, height/2+sin(ang)*j));
    }
  }
  for (int j = 0; j < puntos.size(); j++) {
    Punto aux1 = puntos.get(j);
    for (int i = j+1; i < puntos.size(); i++) {
      Punto aux2 = puntos.get(i);
      float dis = dist(aux1.x, aux1.y, aux2.x, aux2.y);
      if (dis< 100) {
        //float ang = atan2(aux2.y-aux1.y, aux2.x-aux1.x);
        stroke(0,4);
        //stroke(map(ang,-PI,PI,0,256), dist(0,200,200,120), dist(0,200,200,120),map(dist(width/2,height/2,aux2.x,aux2.y),0,width/2,4,8));
        float cdis = dist(aux2.x, aux2.y,width/2,height/2);
        linea(aux1.x, aux1.y, aux2.x, aux2.y, map(cdis,width/2,0,0,3));
        stroke(0,map(dist(width/2,height/2,aux2.x,aux2.y),0,width/2,0,5));
        linea(aux1.x, aux1.y, aux2.x, aux2.y, map(dist(width/2,height/2,aux2.x,aux2.y),0,width/2,0.8,2));
      }
    }
  }
  println("termino");
}

void keyPressed(){
   if(key=='s' || key=='S') saveFrame(timestamp()+"_##.png");
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
