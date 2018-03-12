Jugador j;
PImage ipersonaje, ienemigo, ivida;
ArrayList<Enemigo> enemigos;

void setup() {
  size(640, 480);
  frameRate(60);
  ipersonaje = agrandarImage(loadImage("personaje.png"), 2);
  ienemigo = agrandarImage(loadImage("enemigo.png"), 2);
  ivida = agrandarImage(loadImage("corazon.png"), 2);
  j = new Jugador(width/2, height/2);
  enemigos = new ArrayList<Enemigo>();
  for (int i = 0; i < 4; i++) {
    enemigos.add(new Enemigo(int(random(width)), int(random(height))));
  }
}

void draw() {
  background(0);

  for (int i = 0; i < enemigos.size(); i++) {
   Enemigo aux = enemigos.get(i);
   aux.act();
   if(colisionCuadrado(aux.x,aux.y,aux.tam,j.x,j.y,j.tam)){
   j.vida--; 
   }
   if (aux.eliminar) {
   enemigos.remove(i--);
   }
   }
   j.act();
}

class Jugador {
  boolean arriba, abajo, izquierda, derecha;
  int x, y, tam, vel, vida;
  Jugador(int x, int y) {
    this.x = x;
    this.y = y;
    tam = 40;
    vel = 4;
    vida = 3;
  }
  void act() {
    if (arriba) {
      y -= vel;
    }
    if (abajo) {
      y += vel;
    }
    if (izquierda) {
      x -= vel;
    }
    if (derecha) {
      x += vel;
    }
    if ( x > width + tam) {
      x = -tam;
    }
    if ( y > height + tam) {
      y = -tam;
    }
    if ( x < -tam) {
      x = width +tam;
      ;
    }
    if ( y < -tam) {
      y = height + tam;
    }
    dibujar();
  }

  void dibujar() {
    for (int i = 0; i < vida; i++) {
      image(ivida, 10 + 22 * i, 10);
    }
    image(ipersonaje, x, y);
    //rect(x, y, 20, 20);
  }
}

class Enemigo {
  boolean eliminar;
  int x, y;
  int dir, vida, vel, tam;
  Enemigo(int x, int y) {
    this.x = x;
    this.y = y;
    vida = 3;
    dir = int(random(4));
    vel = 4;
    tam = 40;
    eliminar = false;
  }
  void act() {
    if (random(100) < 1) {
      dir = int(random(4));
    }
    if (vida <= 0) {
      eliminar = true;
    }
    if ( dir == 0) {
      x -= vel;
    }
    if (dir == 1) {
      y -= vel;
    }
    if (dir == 2) {
      x += vel;
    }
    if (dir == 3) {
      y += vel;
    }
    if ( x > width + tam) {
      x = -tam;
    }
    if ( y > height + tam) {
      y = -tam;
    }
    if ( x < -tam) {
      x = width +tam;
      ;
    }
    if ( y < -tam) {
      y = height + tam;
    }
    dibujar();
  }
  void dibujar() {
    image(ienemigo, x, y);
  }
}

void keyPressed() {
  if (keyCode == UP) {
    j.arriba = true;
  }
  if (keyCode == DOWN) {
    j.abajo = true;
  } 
  if (keyCode == LEFT) {
    j.izquierda = true;
  } 
  if (keyCode == RIGHT) {
    j.derecha = true;
  }
}
void keyReleased() {
  if (keyCode == UP) {
    j.arriba = false;
  }
  if (keyCode == DOWN) {
    j.abajo = false;
  } 
  if (keyCode == LEFT) {
    j.izquierda = false;
  } 
  if (keyCode == RIGHT) {
    j.derecha = false;
  }
}


PImage agrandarImage(PImage ori, int es) {
  int wo = ori.width;
  int ho = ori.height;
  PImage nue = createImage(wo*es, ho*es, ARGB);
  nue.loadPixels();
  for (int j = 0; j < ho; j++) {
    for (int i = 0; i < wo; i++) {
      color col = ori.get(i, j);
      for (int dj = 0; dj < es; dj++) {
        for (int di = 0; di < es; di++) {
          nue.set(i*es+di, j*es+dj, col);
        }
      }
    }
  }  
  nue.updatePixels();
  return nue;
}


boolean colisionCuadrado(int x1, int y1, int t1, int x2, int y2, int t2) {
  int disM = (t1+t2)/2;
  int disX = abs((x2+t2/2)-(x1+t1/2));
  int disY = abs((y2+t2/2)-(y1+t1/2));
  if(disX <= disM && disY <= disM){
    return true;
  }
  return false;
}

