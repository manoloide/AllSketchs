ArrayList<Bala> balas; //<>//
ArrayList<Entidad> entidades;
Camara camara;
Escenario escenario;
Jugador jugador;
Input input;
Scroll VELOCIDAD, VIDA, MANA, IMAN, DISTANCIA;
String estado = "juego";
PImage sprites;

void setup() {
  size(800, 600);
  sprites = loadImage("sprites.png");
  camara = new Camara();
  escenario = new Escenario();
  input = new Input();
  jugador = new Jugador(width/2, height/2);
  VELOCIDAD = new Scroll("Velocidad", width/2-100, 180, 200, 20, 1, 8, 1);
  VIDA = new Scroll("Vida", width/2-100, 240, 200, 20, 1, 8, 1);
  MANA = new Scroll("Mana", width/2-100, 300, 200, 20, 1, 8, 1);
  IMAN = new Scroll("Iman", width/2-100, 360, 200, 20, 1, 8, 1);
  DISTANCIA = new Scroll("Distancia", width/2-100, 420, 200, 20, 1, 8, 1);
  iniciar();
}

void draw() {
  if (frameCount%10 == 0) frame.setTitle("fps "+frameRate);
  if(estado.equals("menu")){
    if(input.EDITAR.click){
      estado = "juego";
      iniciar();
    }
    background(0);
    VELOCIDAD.act();
    VIDA.act();
    MANA.act();
    IMAN.act();
    DISTANCIA.act();
    fill(240, 200, 40);
    textAlign(LEFT, TOP);
    textSize(40);
    text(jugador.monedas, 20, 20);
  }
  else if (estado.equals("juego")) {
    camara.act();
    escenario.act();
    if(input.REINICIAR.click) iniciar();
    if(input.EDITAR.click) estado = "menu";
    if (frameCount%80 == 0) entidades.add(new Enemigo(random(width), random(height)));
    for (int i = 0; i < entidades.size(); i++) {
      Entidad e = entidades.get(i);
      e.act();
      if (e.eliminar) entidades.remove(i--);
    }
    for (int i = 0; i < balas.size(); i++) {
      Bala b = balas.get(i);
      b.act();
      for (int j = 0; j < entidades.size(); j++) {
        Entidad e = entidades.get(j);
        if (e != jugador && e instanceof Enemigo && e.colision(b)) {
          e.dano(1);
          b.explotar = true;
          break;
        }
      }
      if (b.eliminar) balas.remove(i--);
    }
    if(jugador.muerto) estado = "menu";
    resetMatrix();
    noStroke();
    fill(250, 53, 34);
    rect(width/2-80, height-56, 160, 20);
    float aw = (jugador.vida/jugador.vida_max)*160;
    fill(220, 23, 4);
    rect(width/2-80+aw, height-56, 160-aw, 20);
    fill(34, 53, 250);
    rect(width/2-80, height-32, 160, 20);
    aw = (jugador.mana/jugador.mana_max)*160;
    fill(4, 23, 220);
    rect(width/2-80+aw, height-32, 160-aw, 20);
    fill(240, 200, 40);
    textAlign(LEFT, TOP);
    textSize(40);
    text(jugador.monedas, 20, 20);
  }
  input.act();
}

void mousePressed() {
  input.mpress();
}

void mouseReleased() {
  input.mreleased();
}

void keyPressed() {
  input.event(true);
}

void keyReleased() {
  input.event(false);
}

void iniciar(){
  balas = new ArrayList<Bala>();
  entidades = new ArrayList<Entidad>();
  entidades.add(jugador);
  jugador.iniciar();
}

class Key { 
  boolean press, click;
  int clickCount;
  void act() {
    if (!focused) release();
    click = false;
    if (press) clickCount++;
  }
  void press() {
    if (!press) {
      click = true; 
      press = true;
      clickCount = 0;
    }
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
  boolean click, dclick, press, released;
  int pressCount, mouseWheel;
  Key ARRIBA, IZQUIERDA, DERECHA, ABAJO, ATACAR, INFO, REINICIAR, EDITAR; 
  Input() {
    click = dclick = released = press = false;
    pressCount = 0;

    ARRIBA = new Key();
    IZQUIERDA = new Key();
    ABAJO = new Key();
    DERECHA = new Key();
    ATACAR = new Key();
    INFO = new Key();
    REINICIAR = new Key();
    EDITAR = new Key();
  }
  void act() {
    mouseWheel = 0;
    if (press) {
      pressCount++;
    }
    click = dclick = released = false;

    ARRIBA.act();
    IZQUIERDA.act();
    ABAJO.act();
    DERECHA.act();
    ATACAR.act();
    INFO.act();
    REINICIAR.act();
    EDITAR.act();
  }
  void mpress() {
    click = true;
    press = true;
  }
  void mreleased() {
    released= true;
    press = false;
  }

  void event(boolean estado) {
    if (key == 'w' || key == 'W' || keyCode == UP) ARRIBA.event(estado);
    if (key == 'a' || key == 'A' || keyCode == LEFT) IZQUIERDA.event(estado);
    if (key == 's' || key == 'S' || keyCode == DOWN) ABAJO.event(estado);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) DERECHA.event(estado);
    if (keyCode == ENTER) ATACAR.event(estado);
    if (key == 'i' || key == 'I') INFO.event(estado);
    if (key == 'r' || key == 'R') REINICIAR.event(estado);
    if (key == 'e' || key == 'E') EDITAR.event(estado);
  }
}

class Camara {
  float x, y, xd, yd;
  Camara() {
    x = 0; 
    y = 0;
  }
  void act() {
    translate(x, y);
  }
}

class Bala {
  boolean explotar, eliminar;
  int tiempo;
  float x, y, dx, dy;
  float vel;
  Bala(float x, float y, float dx, float dy) {
    this.x = x; 
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    vel = 2;
    tiempo = 20;
  }
  void act() {
    if (explotar) {
      tiempo--;
      if (tiempo <= 0) eliminar = true;
    }
    else {
      float ang = atan2(dy-y, dx-x);
      x += cos(ang)*vel;
      y += sin(ang)*vel;
      if (dist(x, y, dx, dy) < vel) {
        explotar = true;
      }
    }
    dibujar();
  }
  void dibujar() {
    /*
    noStroke();
     fill(240, 240, 120);
     ellipse(x, y, 6, 6);
     */
    if (explotar) {
      image(recortar(sprites, 8*(2-tiempo/10), 0, 8, 8), x-4, y-4);
    }
    else {
      image(recortar(sprites, 0, 0, 8, 8), x-4, y-4);
    }
  }
}

class Entidad {
  boolean eliminar;
  float x, y, w, h;
  float vida, vel;
  void act() {
  }
  void dibujar() {
  }
  void dano(float d) {
  }
  boolean colision(Entidad e) {
    return colisionRect(x, y, w, h, e.x, e.y, e.w, e.h);
  }
  boolean colision(Bala b) {
    return colisionRect(x, y, w, h, b.x, b.y, 6, 6);
  }
}

class Jugador extends Entidad {
  boolean inmune, muerto;
  int dir;
  int vida_max, mana_max, distanciaDisparo, iman, inmune_time, monedas;
  float mana;
  Jugador(float x, float y) {
    this.x = x; 
    this.y = y;
    w = h = 20;
    vida = vida_max = 1;
    mana = mana_max = 1;
    vel = 0.25;
    distanciaDisparo = 1;
    iman = 0; 

    monedas = 0;
    inmune = false;
    muerto = false;
  }
  void act() {
    if (frameCount%40 == 0 && mana < mana_max) mana++;
    if(inmune){
      inmune_time--;
      if(inmune_time < 0) inmune = false;
    }
    vel = VELOCIDAD.val/4;
    vida_max = int(VIDA.val);
    mana_max = int(MANA.val);
    if (input.ARRIBA.press) {
      dir = 0;
      y += -vel;
    }
    else if (input.ABAJO.press) {
      dir = 2;
      y += vel;
    }
    else if (input.IZQUIERDA.press) {
      dir = 3;
      x += -vel;
    }
    else if (input.DERECHA.press) {
      dir = 1;
      x += vel;
    }
    if (input.ATACAR.click) {
      disparar();
    }
    for (int i = 0; i < entidades.size(); i++) {
      Entidad e = entidades.get(i);
      if (e != this && colision(e)) {
        if(e instanceof Enemigo) dano(1);
        if(e instanceof Moneda){
          e.eliminar = true;
          jugador.monedas++;
        }
      }
    }
    dibujar();
  }
  void dibujar() {
    if(inmune && frameCount%20 < 10) return;
    noStroke();
    fill(200, 200, 80);
    rect(x-w/2, y-h/2, w, h);
  }
  void iniciar(){
    x = width/2;
    y = height/2;
    muerto = false;
    vida = vida_max;
  }
  void disparar() {
    if (mana < 1) return;
    mana--;
    int d = int(DISTANCIA.val*20);
    switch(dir) {
    case 0:
      balas.add(new Bala(x, y, x, y-d));
      break;
    case 1:
      balas.add(new Bala(x, y, x+d, y));
      break;
    case 2:
      balas.add(new Bala(x, y, x, y+d));
      break;
    case 3:
      balas.add(new Bala(x, y, x-d, y));
      break;
    }
  }
  void dano(float d) {
    if(inmune) return;
    inmune = true;
    inmune_time = 60;
    vida -= d;
    if (vida <= 0) muerto = true;
  }
}

class Enemigo extends Entidad {
  Enemigo(float x, float y) {
    this.x = x; 
    this.y = y;
    w = h = 20;
    vida = 3;
    vel = 0.5;
  }
  void act() {
    float ang = atan2(jugador.y-y, jugador.x-x);
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    dibujar();
  }
  void dibujar() {
    noStroke();
    fill(200, 80, 80);
    rect(x-w/2, y-h/2, w, h);
  }
  void dano(float d) {
    vida -= d;
    if (vida <= 0){
      eliminar = true;
      int cant = int(random(3));
      for(int i = 0; i < cant; i++){
        entidades.add(0,new Moneda(x+random(-4, 4), y+random(-4, 4))); 
      }
    }
  }
}

class Moneda extends Entidad {
  Moneda(float x, float y) {
    this.x = x; 
    this.y = y;
    w = h = 8;
    vida = 300 + int(random(60));
  }
  void act() {
    vida--;
    if(vida < 0) eliminar = true;
    dibujar();
  }
  void dibujar() {
    if(vida < 80 && vida%(20) < 10) return;
    noStroke();
    fill(240, 200, 40);
    ellipse(x, y, w, h);
  }
}

class Escenario {
  int w, h;
  Escenario() {
  }
  void act() {
    dibujar();
  }
  void dibujar() {
    background(0);
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
      res[i][j] = recortar(ori, i*ancho, j*alto, ancho, alto);
    }
  }
  return res;
}

boolean colisionRect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  float disX = w1/2 + w2/2;
  float disY = h1/2 + h2/2;
  if (abs(x1 - x2) < disX && abs(y1 - y2) < disY) {
    return true;
  }  
  return false;
}

class Scroll{
  boolean move;
  int val;
  float x, y, w, h; 
  float max, min;
  String nombre;
  Scroll(String nombre, float nx, float ny, float nw, float nh, float nmin, float nmax, float nvar) {
    this.nombre = nombre;
    x = nx;
    y = ny;
    w = nw;
    h = nh;
    max = nmax;
    min = nmin;
    val = int(nvar);
    move = false;
  }

  void act() {
    if (mousePressed) {
      if ( mouseX + 8 >= x + h/2 && mouseX - 8 <= x + w - h/2+ 8 && mouseY > y && mouseY <= y+h) {
        move = true;
      }
    }
    else {
      move = false;
    }
    if (move) {
      float posX = mouseX;
      if (posX < x) {
        posX = x;
      }
      else if (posX > x +w) {
        posX = x + w;
      }
      val = (int)(min + (max-min) * ((posX- h/2 - x )/(w - h)));
      if (val < min) {
        val = (int)min;
      }
      else if (val > max) {
        val = (int)(int)max;
      }
    }
    dibujar();
  }

  void dibujar() {
    fill(120);
    rect(x, y, w, h);

    fill(150);
    float pos = x + ((w-h) * (val-min)/(max-min));
    rect(pos, y, h, h);
    fill(255);
    text(nombre+" "+val, x+2, y+9);
  }
}