final int ESCALA = 2;  //<>//

Input input = new Input();
Jugador j;
PImage sprites;
PImage sprite[][]; 

void setup() {
  size(800, 600);
  frame.setResizable(true);
  sprites = loadImage("sprites.png");
  sprite = recortarImagen(sprites,32,32,ESCALA);

  j = new Jugador(0, 0);
}

void draw() {
  if (frameCount%10 == 0) frame.setTitle("Matador -- FPS:"+frameRate);
  background(20);
  j.act();
  input.act();
}

void keyPressed() {
  input.event(true);
}
void keyReleased() {
  input.event(false);
}

class Jugador {
  int dir;
  float x, y, vel; 
  Jugador(float x, float y) {
    this.x = x; 
    this.y = y;
    vel = 0.5;
  }
  void act() {
    if (input.ARRIBA.press) {
      dir = 2; 
      y -= vel;
    }
    else if (input.ABAJO.press) {
      dir = 0;
      y += vel;
    }
    else if (input.IZQUIERDA.press) {
      dir = 3;
      x -= vel;
    }
    else if (input.DERECHA.press) {
      dir = 1;
      x += vel;
    }
    dibujar();
  }

  void dibujar() {
    image(sprite[dir][0],int(x), int(y));
  }
}

class Tile {
}

class Mapa {
  int w, h;
  Tile[][] tiles; 
  Mapa(int w, int h) {
    this.w = w; 
    this.h = h;
    tiles = new Tile[w][h];
  }
}

class Key { 
  boolean press, click;
  int clickCount;
  void act() {
    click = false;
    if (press) clickCount++;
  }
  void press() {
    click = true; 
    press = true;
    clickCount = 0;
  }
  void release() {
    press = false;
  }
  void event(boolean estado) {
    if (estado) press();
    else release();
  }
}

class Input {
  Key ARRIBA, IZQUIERDA, ABAJO, DERECHA; 
  Input() {
    ARRIBA = new Key();
    IZQUIERDA = new Key();
    ABAJO = new Key();
    DERECHA = new Key();
  }
  void act() {
    ARRIBA.act();
    IZQUIERDA.act();
    ABAJO.act();
    DERECHA.act();
  }
  void event(boolean estado) {
    if (key == 'w' || key == 'W' || keyCode == UP) ARRIBA.event(estado);
    if (key == 'a' || key == 'A' || keyCode == LEFT) IZQUIERDA.event(estado);
    if (key == 's' || key == 'S' || keyCode == DOWN) ABAJO.event(estado);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) DERECHA.event(estado);
  }
}


PImage recortar(PImage ori, int x, int y, int w, int h) {
  PImage aux = createImage(w, h, ARGB);
  aux.copy(ori, x, y, w, h, 0, 0, w, h);
  return aux;
}

PImage[][] recortarImagen(PImage ori, int ancho, int alto, int es) {
  int cw = ori.width/ancho;
  int ch = ori.height/alto;
  PImage res[][] = new PImage[cw][ch];
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      PImage aux = recortar(ori, i*ancho, j*alto, ancho, alto);
      res[i][j] = ampliar(aux, es);
    }
  }
  return res;
}

PImage ampliar(PImage ori, int es) {
  int ancho =  ori.width; 
  int alto = ori.height;
  PImage res = createImage(ancho*es, alto*es, ARGB);
  for (int j = 0; j < alto; j++) {
    for (int i = 0; i < ancho; i++) {
      color col = ori.get(i, j);
      for (int k = 0; k < es; k++) {
        for (int l = 0; l < es; l++) {
          res.set(i*es+l, j*es+k, col);
        }
      }
    }
  }
  return res;
}
