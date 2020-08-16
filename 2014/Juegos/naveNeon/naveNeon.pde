ArrayList<Tiro> tiros;
Input input;
Nave nave;

void setup() {
  size(800, 600);
  tiros = new ArrayList<Tiro>();
  input = new Input();
  nave = new Nave(width/2, height/2);
}

void draw() {
  background(4);
  for (int i = 0; i < tiros.size (); i++) {
    Tiro t = tiros.get(i);
    t.update();
    if (t.eliminar) tiros.remove(i--);
  }
  nave.update();
  input.act();
}

void keyPressed() {
  input.event(true);
}

void keyReleased() {
  input.event(false);
}

class Nave {
  float x, y, tam, velX, velY, velMax, ace;
  Nave(float x, float y) {
    this.x = x; 
    this.y = y;
    tam = 12;
    velX = 0;
    velY = 0;
    velMax = 4;
    ace = 0.2;
  }
  void update() {
    if (input.ATACAR.click) tiros.add(new Tiro(x, y, 0));
    if (input.IZQUIERDA.press) {
      velX = (velX < -velMax)? -velMax : velX-ace;
    } else if (input.DERECHA.press) {
      velX = (velX > velMax)? velMax : velX+ace;
    } else {
      velX *= 0.9;
    }
    if (input.ARRIBA.press) {
      velY = (velY < -velMax)? -velMax : velY-ace;
    } else if (input.ABAJO.press) {
      velY = (velY > velMax)? velMax : velY+ace;
    } else {
      velY *= 0.9;
    }
    x += velX;
    y += velY;
    draw();
  }
  void draw() {
    noFill();
    stroke(#036AE7);
    strokeWeight(3);
    triangle(x-tam, y-tam/2, x-tam, y+tam/2, x+tam, y);
  }
}

class Tiro {
  boolean eliminar;
  float x, y, vel, ang;
  Tiro(float x, float y, float ang) {
    this.x = x; 
    this.y = y;
    this.ang = ang;
    vel = 6;
  } 
  void update() {
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    draw();
  }
  void draw() {
    float dx = cos(ang)*4;
    float dy = sin(ang)*4;
    line(x-dx, y-dy, x+dx, y+dy);
  }
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
  Key ARRIBA, IZQUIERDA, DERECHA, ABAJO, ATACAR; 
  Input() {
    ARRIBA = new Key();
    IZQUIERDA = new Key();
    DERECHA = new Key();
    ABAJO = new Key();
    ATACAR = new Key();
  }
  void act() {
    ARRIBA.act();
    IZQUIERDA.act();
    DERECHA.act();
    ABAJO.act();
    ATACAR.act();
  }
  void event(boolean estado) {
    if (key == 'w' || key == 'W' || keyCode == UP) ARRIBA.event(estado);
    if (key == 'a' || key == 'A' || keyCode == LEFT) IZQUIERDA.event(estado);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) DERECHA.event(estado);
    if (key == 's' || key == 'S' || keyCode == DOWN) ABAJO.event(estado);
    if (key == ' ') ATACAR.event(estado);
  }
}
