/*
  Cosas a hacer:
    - Agregar variaciones de tiles
    - Agregar herramientas y picado
    - Agregar enemigos
    - Agregar materiales
    - Agregar crafteos
    - Agregar cultivos
    - Agregar stats player
    - Buscar objectivos
    - Agregar materiales
      - Carbon, Oro, Cobre, Arena, Grava, 
      - 
*/

int ID_NADA = 0;
int ID_TIERRA = 1;
int ID_PASTO = 2;
int ID_PIEDRA = 3;
int ID_ARENA = 4;

int COLOR_NADA = #FFFFFF;
int COLOR_TIERRA = #674C22;
int COLOR_PASTO = #5D9332;
int COLOR_PIEDRA = #494D45;
int COLOR_ARENA = #EDE84D;

int MAPA_WIDTH = 200; 
int MAPA_HEIGHT = 128;

int TILE_SIZE = 64;

PImage Tiles[];
PImage Fondo[];


Camera camera;
Input input;
Player player;
World world;

void setup() {
  size(800, 600);
  imageMode(CENTER);
  rectMode(CENTER);
  generarSprites();
  camera = new Camera();
  input = new Input();
  player = new Player();
  world = new World();
}


void draw() {
  background(#A6C4F5);
  pushMatrix();
  camera.moved(-player.x, -player.y);
  camera.update();
  world.update();
  player.update();
  popMatrix();
  dibujarIntefaz();

  input.update();
}

class Camera {
  float x, y, ix, iy;
  float vel = 0.5;
  void update() {
    x += (ix-x)*vel;
    y += (iy-y)*vel; 
    translate(int(x+width/2), int(y+height/2));
  }
  void moved(float ix, float iy) {
    this.ix = ix; 
    this.iy = iy;
  }
}

void dibujarIntefaz() {
  int xx = int(mouseX-camera.x+TILE_SIZE/2-width/2) /TILE_SIZE;
  int yy = int(mouseY-camera.y+TILE_SIZE/2-height/2) /TILE_SIZE;
  strokeWeight(4);
  stroke(5);
  noFill();
  rect(xx*TILE_SIZE, yy*TILE_SIZE, TILE_SIZE, TILE_SIZE);
  int cantidadMateriales = player.inventario.length;
  float tt = 50;
  float es = 20;
  float posi = height/2-(tt*cantidadMateriales+es*(cantidadMateriales-1))/2.+tt/2;
  for (int i = 0; i < cantidadMateriales; i++) {
    if (i == player.seleccionado) {
      stroke(80);
    } else {
      stroke(40);
    }
    fill(60);
    float x = width-es-tt/2;
    float y = posi+(tt+es)*i;
    rect(x, y, tt, tt, 8);
    if (player.inventario[i][1] > 0) {
      image(Tiles[player.inventario[i][0]], x, y, TILE_SIZE/2, TILE_SIZE/2);
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(22);
      text(player.inventario[i][1], x, y-3);
    }
  }
}
