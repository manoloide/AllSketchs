PImage sprites,snave;
Estrella estrellas[];
int cantidad_estrellas = 100;
//teclas 
boolean ARRIBA = false;
boolean ABAJO = false;
boolean DERECHA = false;
boolean IZQUIERDA = false;

Jugador j; 

void setup() {
  size(480, 640); 
  sprites = loadImage("sprites.png");
  snave = recortarImagen(sprites,0,0,20,40);
  estrellas = new Estrella[cantidad_estrellas];
  for (int i = 0; i < cantidad_estrellas; i++) {
    estrellas[i] = new Estrella();
  }
  j = new Jugador();
  frameRate(60);
  noCursor();
}

void draw() {
  background(0);
  for (int i = 0; i < cantidad_estrellas; i++) {
    estrellas[i].act();
  }
  j.act();
  stroke(220, 200);
  line(mouseX-6, mouseY, mouseX+6, mouseY);
  line(mouseX, mouseY-6, mouseX, mouseY+6);
}

void keyPressed() {
  if (key == 'w') {
    ARRIBA = true;
  } 
  if (key == 's') {
    ABAJO = true;
  } 
  if (key == 'a') {
    IZQUIERDA = true;
  } 
  if (key == 'd') {
    DERECHA = true;
  }
}

void keyReleased() {
  if (key == 'w') {
    ARRIBA = false;
  } 
  if (key == 's') {
    ABAJO = false;
  } 
  if (key == 'a') {
    IZQUIERDA = false;
  } 
  if (key == 'd') {
    DERECHA = false;
  }
}

class Estrella {
  float x, y;
  int tam, mtam;
  Estrella() {
    x = random(width);
    y = random(height);
    tam = int(random(3))+1;
    mtam = tam/2;
  }
  void act() {
    y += 0.1 + tam*1./9;
    dibujar();
    if (y-tam > height) {
      x = random(width);
      y = random(50)*-1;
      tam = int(random(3))+1;
      mtam = tam/2;
    }
  }
  void dibujar() {
    rect(x-mtam, y-mtam, tam, tam);
  }
}


class Jugador {
  int w, h;
  float x, y, vel; 
  Jugador() {
    x = width/2;
    y = height/2;
    vel = 4;
    w = 20; 
    h = 40;
  }
  void act() {
    if (ARRIBA) {
      y -= vel;
    }
    else if (ABAJO) {
      y += vel;
    }
    else if (IZQUIERDA) {
      x -= vel;
    }
    else if (DERECHA) {
      x += vel;
    }
    if (x < w/2) {
      x = w/2;
    }
    else if ( x > width-w/2) {
      x = width-w/2;
    }
    if (y < h/2) {
      y = h/2;
    }
    else if ( y > height-h/2) {
      y = height-h/2;
    }
    dibujar();
  }
  void dibujar() {
    image(snave,x-w/2,y-h/2);
    //triangle(x-10, y+10, x, y-10, x+10, y+10);
  }
}

PImage recortarImagen(PImage ori, int x, int y, int w, int h) {
  PImage aux = createImage(w, h, ARGB);
  aux.loadPixels();
  for(int j = 0; j < h; j++){
    for(int i = 0; i < w; i++){
        aux.pixels[j*w+i] = ori.pixels[(j+y)*ori.width+(x+i)];
    }
  }
  aux.updatePixels();
  return aux;
}

