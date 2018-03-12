
/*http://www.youtube.com/watch?v=PMWonO8jsdU
*/
String texto = "Yo no se , mira, es terrible como llueve, llueve todo el tiempo, afuera tupido y gris, aqui contra el balcón con goterones cuajados y duros, que hacen PLAF y se aplastan como bofetadas uno detrás de otro, que hastió, ahora aparece una gotita en lo alto del marco de la ventana, se queda temblequeando contra el cielo que la triza en mil brillos apagados, va creciendo y se tambalea, ya va a caer y no se cae , todavía no se cae . Esta prendida con todas las uñas no quiere caerse y se la ve que se agarra con los dientes mientras le crece la barriga, ya es una gotaza que cuelga majestuosa, y de pronto zup , ahi va, plaf, deshecha,nada, una viscosidad en el mármol. pero las hay que se suicidan y se entregan enseguida,brotan en el marco y ahí mismo se tiran, me parece ver la vibración del salto, sus piernitas desprendiéndose, y el grito que las emborracha en esa nada del caer y aniquilarse. Tristes gotas,redondas inocentes gotas, adiós gotas. Adiós.";
String[] palabras = texto.split(" ");

ArrayList<Linea> lineas;
ArrayList<Texto> textos;
Camara camara;
color paleta[];

void setup() {
  size(1920, 1080, P3D); 
  //smooth(8);
  strokeWeight(1.2);
  camara = new Camara();
  paleta = new color[3];
  paleta[0] = #F9F9F9;
  paleta[1] = #FC9545;
  paleta[2] = #6E6F69;
  lineas = new ArrayList<Linea>();
  textos = new ArrayList<Texto>();
  for (int i = 0; i < 0; i++) {
    color col = paleta[int(random(1)*random(3))]; 
    float x = random(-200, 200);
    float y = random(-200, 200);
    float z = random(-200, 200);
    Linea aux; 
    if (random(10) < 5) {
      aux = new Linea(x, -y, z, x, y, z, col);
    }
    else {
      if (random(10) < 3) {
        aux = new Linea(x, y, -z, x, y, z, col);
      }
      else {
        aux = new Linea(-x, y, z, x, y, z, col);
      }
    }
    lineas.add(aux);
  }
}

void draw() {
  Texto aux = new Texto(palabras[int(random(palabras.length))], random(-200, 200), random(-200, 200), random(-200, 200));
  aux.ry = (TWO_PI/4)*int(random(4));
  textos.add(aux);
  background(#26212C);
  camara.act();
  for (int i = 0; i < lineas.size(); i++) {
    lineas.get(i).dibujar();
  }
  for (int i = 0; i < textos.size(); i++) {
    aux = textos.get(i);
    aux.act();
    if(aux.eliminar) textos.remove(i--);
  }
}

class Punto {
  float x, y, z;
  Punto(float x, float y, float z) {
    this.x = x; 
    this.y = y;
    this.z = z;
  }
}

class Linea {
  color col;
  Punto p1, p2;
  Linea(float x1, float y1, float z1, float x2, float y2, float z2, color col) {
    this.col = col;
    p1 = new Punto(x1, y1, z1);
    p2 = new Punto(x2, y2, z2);
  } 
  void dibujar() {
    stroke(col);
    line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
  }
}

class Texto {
  boolean eliminar;
  color col;
  float x, y, z, rx, ry;
  String text; 
  Texto(String text, float x, float y, float z) {
    this.x = x; 
    this.y = y; 
    this.z = z; 
    this.text = text;
    eliminar = false;
    col = paleta[int(random(1)*random(3))];
  }
  void act() {
    dibujar();
  }
  void dibujar() {
    fill(col);
    pushMatrix();
    translate(x, y, z);
    rotateX(rx);
    rotateY(ry);
    text(text, -textWidth(text)/2, 0);
    popMatrix();
  }
}

class Camara {
  float x, y, z, rotx, roty, vely;
  int time;
  Camara() {
    x = width/2;
    y = height/2;
    z = -100;
    rotx = -0.8046021;
    roty = 4.3054013;
  }
  void act() {
    rotx += cos(((frameCount%1000)/1000.) * TWO_PI)/-1000;
    roty += vely;
    time--;
    if (time <= 0) randomCam();
    float tem = 0;//random(1);
    translate(x+random(-tem, tem), y+random(-tem, tem), z+random(-tem, tem));
    rotateX(rotx);
    rotateY(roty);
    //scale(1.5);
    //scale(map(frameCount,0,25*90,0.23,0.65));
  }
  void randomCam() {
    roty = random(TWO_PI); 
    rotx = random(PI*1.7, TWO_PI);
    vely = random(-0.005, 0.005);
    time = int(random(12, 140));
    /*
    int r = int(random(objetos.size()));
     x = objetos.get(r).x;
     y = objetos.get(r).y;
     z = objetos.get(r).z;*/
    //camera(width/2.0-x, height/2.0-y, (height/2.0) / tan(PI*30.0 / 180.0)-z, width/2.0, height/2.0, 0, 0, 1, 0);
  }
}
