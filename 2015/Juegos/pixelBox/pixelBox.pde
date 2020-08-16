int sizeTile = 32;
int tileColors[] = {
  #FAD089, 
  #FF9C5B, 
  #F5634A, 
  #ED303C, 
  #3B8183
};
int tileTypes = tileColors.length;

int mapWidth, mapHeigth;
int desX, desY;
int map[][];

int MENU = 1, GAME = 2, SHOP = 3;
int estado = GAME;

int pixelSize = 2;
PGraphics master;

int coins = 0;
int clicks = 100;
int time = 60;

PFont font; 

ArrayList<Particle> particles;

void setup() {
  size(400, 600);
  font = createFont("pixelmix.ttf", 8, false);
  noSmooth();
  mapWidth = width/pixelSize/sizeTile;
  mapHeigth = height/pixelSize/sizeTile;
  desX = (width/pixelSize-mapWidth*sizeTile)/2;
  desY = (height/pixelSize-mapHeigth*sizeTile)/2;
  
  createMap();

  master = createGraphics(width/pixelSize, height/pixelSize);
  master.noSmooth();

  particles = new ArrayList<Particle>();
}

void draw() {

  if (estado == GAME) {
    drawBackground();
    updateClean();
    removeCube();
    addBlock();
    drawMap();
    drawParticles();
    drawUi();
  }
  image(master.get(), 0, 0, width, height);
}

void mousePressed() {
  if (estado == GAME) {
    if (clicks <= 0) return;
    int px = (mouseX/pixelSize-desX)/sizeTile;
    int py = (mouseY/pixelSize-desY)/sizeTile; 
    if (px >= 0 && px <mapWidth && py >= 0 && py <mapHeigth && map[px][py] != 0) {
      map[px][py] %= tileTypes; 
      map[px][py]++;
      clicks--;
    }
  }
}

void createMap() {
  map = new int[mapWidth][mapHeigth];
  for (int j = 0; j < mapHeigth; j++) {
    for (int i = 0; i < mapWidth; i++) {
      map[i][j] = (int) random(1, tileTypes+1);
    }
  }
}
void drawBackground() {
  master.background(20);
  /*
  master.stroke(26);
   master.strokeWeight(2);
   int esp = 6;
   for (int i = 0; i < height; i+=esp) {
   master.line(i+frameCount/10%esp, -2, -2, i+frameCount/10%esp);
   }
   master.strokeWeight(1);
   */
}
void drawMap() {
  master.beginDraw();
  master.noSmooth();
  int dx = (master.width-mapWidth*sizeTile)/2;
  int dy = (master.height-mapHeigth*sizeTile)/2;
  for (int j = 0; j < mapHeigth; j++) {
    for (int i = 0; i < mapWidth; i++) {
      if (map[i][j] == 0) continue;
      int tile = map[i][j]-1;
      color col = tileColors[tile];
      master.stroke(osc(col, 30));
      master.fill(col);
      master.rect(i*sizeTile+dx, j*sizeTile+dy, sizeTile-1, sizeTile-1, 6);
    }
  }
  master.endDraw();
}

void drawParticles() {
  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.update();
    if (p.remove) particles.remove(i--);
  }
}

void drawUi() {
  int hh = 16;
  master.noStroke();
  master.fill(60);
  master.rect(0, 0, master.width, hh);
  master.stroke(54);
  master.line(0, hh, master.width, hh);
  master.stroke(0, 20);
  master.line(0, hh+1, master.width, hh+1);
  master.textFont(font);
  master.fill(10);
  master.textAlign(LEFT, TOP);
  master.text("Coins "+coins, 10, hh-10);
  master.textAlign(CENTER, TOP);
  master.text("Time "+time, master.width/2, hh-10);
  master.textAlign(RIGHT, TOP);
  master.text("Clicks "+clicks, master.width-10, hh-10);
  master.fill(240);
  master.textAlign(LEFT, TOP);
  master.text("Coins "+coins, 10, hh-11);
  master.textAlign(CENTER, TOP);
  master.text("Time "+time, master.width/2, hh-11);
  master.textAlign(RIGHT, TOP);
  master.text("Clicks "+clicks, master.width-10, hh-11);
}

void addBlock() {
  for (int i = 0; i < mapWidth; i++) {
    if (map[i][0] == 0) {
      map[i][0] = (int) random(1, tileTypes+1);
    }
  }
}

void removeCube() {
  for (int j = 0; j < mapHeigth-1; j++) {
    for (int i = 0; i < mapWidth-1; i++) {
      int tile = map[i][j];
      if (tile == 0) continue;
      if (tile == map[i+1][j] && tile == map[i][j+1] && tile == map[i+1][j+1]) {
        map[i][j] = 0;
        map[i+1][j] = 0;
        map[i][j+1] = 0;
        map[i+1][j+1] = 0;
        coins++;
        particles.add(new TextParticle("+1", (i+1)*sizeTile+desX, (j+1)*sizeTile+desY));
      }
    }
  }
}

void updateClean() {
  for (int j = mapHeigth-1; j > 0; j--) {
    for (int i = mapWidth-1; i >= 0; i--) {
      int tile = map[i][j];
      if (tile == 0) {
        map[i][j] = map[i][j-1];
        map[i][j-1] = 0;
      }
    }
  }
}

int osc(int ori, float osc) {
  return color(red(ori)-osc, green(ori)-osc, blue(ori)-osc, alpha(ori));
}


class Particle {
  boolean remove;
  float x, y;
  void update() {
  }
  void show() {
  }
}

class TextParticle extends Particle {
  float vel, ang;
  int time;
  String text;
  TextParticle(String text, float x, float y) {
    this.text = text;
    this.x = x;
    this.y = y;

    time = 50;
    vel = 0.25;
    ang = TWO_PI-PI/2;
  }
  void update() {
    time--;
    if (time < 0) remove = true;
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    show();
  }
  void show() {
    master.textFont(font);
    master.textAlign(CENTER, CENTER);
    master.stroke(#DBB000);
    master.fill(#FFD736);
    master.ellipse(int(x), int(y), 20, 20);
    master.fill(10);
    master.text(text, int(x)+1, int(y)+1);
    master.fill(240);
    master.text(text, int(x), int(y));
  }
}
