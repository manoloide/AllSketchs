/*
 -bonetes generativos
 -rediseñar fuente y placas
 -loading surattack
 -mejores puntos
 */

/* @pjs preload="img/fondojuan.jpg"; */
/* @pjs preload="img/jnbody.png" */
/* @pjs preload="img/cara1.png" */
/* @pjs preload="img/cara2.png" */
/* @pjs preload="img/cara3.png" */
/* @pjs preload="img/cara4.png" */
/* @pjs preload="img/cara5.png" */
/* @pjs preload="img/cara6.png" */
/* @pjs preload="img/jnbodye.png" */
/* @pjs preload="img/carae1.png" */
/* @pjs preload="img/carae2.png" */
/* @pjs preload="img/carae3.png" */
/* @pjs preload="img/carae4.png" */
/* @pjs preload="img/carae5.png" */
/* @pjs preload="img/carae6.png" */


ArrayList<Bonete> bonetes;
int puntos, contador;
Juandi juandi;
String estado; //inicio, juego, final;
PImage cuerpo[], fondo;
PImage cara[][];

void setup() {
  size(800, 600);
  fondo = loadImage("img/fondojuan.jpg");
  cuerpo = new PImage[2];
  cuerpo[0] = loadImage("img/jnbody.png"); 
  cuerpo[1] = loadImage("img/jnbodye.png"); 
  cara = new PImage[6][2];
  for (int i = 0; i < 6; i++) {
    cara[i][0] = loadImage(("img/cara"+(i+1)+".png"));
    cara[i][1] = loadImage(("img/carae"+(i+1)+".png"));
  }
  imageMode(CENTER);
  rectMode(CENTER);
  bonetes = new ArrayList<Bonete>();
  juandi = new Juandi();
  textAlign(CENTER, CENTER);
  textSize(60);
  estado = "inicio";
  iniciar();
}

void draw() {
  image(fondo, width/2, height/2);
  if (estado.equals("inicio")) {
    if (mousePressed) estado = "juego";
    textSize(40);
    text("BIENVENIDO AL JUEGO DE JUANDI, JUNTA BONETES QUE NO SE TE ESCAPEN", width/2-200, height/2-220, 400, 400);
  }
  if (estado.equals("juego")) {
    if (frameCount%60 == 0) contador--;
    int caen = int(map(contador, 60, 0, 70, 20));
    if (frameCount%caen == 0) bonetes.add(new Bonete(random(60, width-60), random(-80, -40)));
    for (int i = 0; i < bonetes.size (); i++) {
      Bonete b = bonetes.get(i); 
      b.update(); 
      if (colisionRect(b.x, b.y, b.w, b.h, juandi.x, juandi.y, juandi.w, juandi.h)) {
        b.eliminar = true;
        puntos += 200;
      }
      if (b.eliminar) bonetes.remove(i--);
    }
    juandi.update();
    fill(250);
    textSize(60);
    text(puntos, width/3, 40);
    text(contador, (width/3)*2, 40);
    if (contador < 0) estado = "final";
  }
  if (estado.equals("final")) {
    textSize(40);
    text("tu puntuacion fue: "+puntos, width/2-200, height/2-250, 400, 400);
    if (mousePressed) {
      iniciar();
      estado = "juego";
    }
  }
}

void iniciar() {
  bonetes = new ArrayList<Bonete>();
  puntos = 0; 
  contador = 60;
}

class Juandi {
  float x, y, w, h;
  int dir;
  Juandi() {
    w = 80;
    h = 320;
    x = width/2;
    y = height-h*0.6;
  }
  void update() {
    float mx = mouseX;
    if (mx < w) mx = w;
    if (mx > width-w) mx = width-w;
    float dx = mx-x;
    if (dx < 0) dir = 1;
    else dir = 0;
    x += dx/22; 
    dibujar();
  }
  void dibujar() {
    image(cuerpo[dir], x, y);
    int frame = int(frameCount/60)%6;
    image(cara[frame][dir], x, y-145);
    /*
    rectMode(CENTER);
    fill(255, 0, 0, 200);
    rect(x, y, w, h);
    */
  }
}

class Bonete {
  boolean eliminar;
  float x, y, w, h, vel;
  Bonete(float x, float y) {
    this.x = x;
    this.y = y;
    w = 34;
    h = 40;
  }
  void update() {
    y += 2 + map(contador, 0, 60, 2, 0);
    if (y >height+h) {
      eliminar = true;
      puntos -= 100;
    }
    dibujar();
  }
  void dibujar() {
    fill(0, 255, 0);
    rect(x, y, w, h);
  }
}

boolean colisionRect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  float disX = w1/2 + w2/2;
  float disY = h1/2 + h2/2;
  if (abs(x1 - x2) < disX && abs(y1 - y2) < disY) {
    return true;
  }  
  return false;
}
