ArrayList<Objeto> objetos;
boolean keyClick, gameOver;
float velx;
float puntos;
int time;
Player player;
String state;

void setup() {
  size(800, 500); 
  state = "menu";
  reset();

  textSize(32);
  textAlign(CENTER, CENTER);
}

void reset() {
  velx = 5;
  puntos = 0;
  time = 0;
  gameOver = false;
  player = new Player(width/4, height*0.5);
  objetos = new ArrayList<Objeto>();
}

void draw() {

  if (state.equals("menu")) {
    updateMenu();
  } else if (state.equals("game")) {
    updateGame();
  } else if (state.equals("gameover")) {
    updateGameOver();
  }
  
  keyClick = false;
}

void updateMenu() {
  if (keyClick) {
    reset();
    state = "game";
  }

  background(0);
  fill(255);
  text("MENU", width/2, height/2);
}

void updateGame() {
  velx += 0.001;
  puntos += velx*0.1;
  background(180, 180, 240);
  noStroke();
  fill(60, 60, 220);
  float a1 = cos(frameCount*0.07)*14;
  float a2 = cos(frameCount*0.07+PI*0.7)*14;
  beginShape();
  vertex(0, height*0.37+a1);
  vertex(width, height*0.37+a2);
  vertex(width, height);
  vertex(0, height);
  endShape();

  if (random(1) < 0.01) {
    objetos.add(new Tiburon());
  }

  if (random(1) < 0.003) {
    objetos.add(new Pizza());
  }

  for (int i = 0; i < objetos.size (); i++) {
    Objeto o = objetos.get(i);
    o.update();
    if (o.remove) objetos.remove(i--);
  }
  player.update();

  if (gameOver) {
    state = "gameover";
  }

  text("Puntos: "+int(puntos), width/2, 30);
}

void updateGameOver() {
  if (keyClick) {
    state = "menu";
  }

  background(0);
  fill(255);
  text("GAME OVER", width/2, height/2);
}


void keyPressed() {
  keyClick = true;
  if (keyCode == UP || key == 'w') player.up = true; 
  if (keyCode == DOWN || key == 's') player.down = true;
}

void keyReleased() {
  if (keyCode == UP || key == 'w') player.up = false; 
  if (keyCode == DOWN || key == 's') player.down = false;
}

void mousePressed() {
  keyClick = true;
  if (mouseY+player.h/2 < player.y) player.up = true; 
  if (mouseY-player.h/2 > player.y) player.down = true;
}

class Player {
  boolean up, down;
  float cy, dy;
  float x, y, w, h;
  int carril;
  Player(float x, float y) {
    this.x = x; 
    this.y = y;
    cy = y;
    w = 48;
    h = 80;
    dy = 100;
    rectMode(CENTER);
    carril = 1;
  }

  void update() {
    if (up) {  
      carril--;
      if (carril < 0) carril = 0;
    } else if (down) {
      carril++;
      if (carril > 2) carril = 2;
    }
    y += ((cy+carril*dy)-y)*0.2;
    up = false; 
    down = false;
    show();
  }

  void show() {
    fill(255, 120, 80);
    rect(x, y, w, h);
  }
}

class Objeto {
  boolean remove;
  float x, y, w, h;
  float vel;
  int carril;
  Objeto() {
    w = 60; 
    h = 60;
    carril = int(random(3));
    x += width+h*random(1, 2.5);
    int dy = 100;
    y = height*0.5+carril*dy;
    vel = 3;
  }

  void update() {
    x -= velx;
    if (x < -w) {
      remove = true;
    }
    if (rectCollision(x, y, w, h, player.x, player.y, player.w, player.h)) {
      collision();
    }
    show();
  }

  void show() {
  }

  void collision() {
    remove = true;
  }
}

class Tiburon extends Objeto {
  Tiburon() {
    super();
  }
  void show() {
    fill(160);
    arc(x+w/2, y+h/2, w*2, h*2, PI, PI*1.6);
  }  
  void collision() {
    gameOver = true;
    remove = true;
  }
}

class Pizza extends Objeto {
  Pizza() {
    super();
  }
  void show() {
    fill(240, 240, 180);
    ellipse(x, y, w, h);
  }

  void collision() {
    puntos += 250;
    remove = true;
  }
}


boolean rectCollision(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  fill(255, 0, 0, 80);
  rect(x1, y1, w1, h1);
  rect(x2, y2, w2, h2);

  float dx = abs(x1-x2);
  float dy = abs(y1-y2);
  return dx < (w1+w2)/2 && dy < (h1+h2)/2;
}

